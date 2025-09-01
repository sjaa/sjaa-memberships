#!/usr/bin/env ruby

# SolidQueue Job Executor Script for Rails 8
# This script finds ready jobs and executes them using a simplified approach

require 'bundler/setup'

class SolidQueueSimpleWorker
  def initialize(options = {})
    @queues = options[:queue_names] || ['default']
    @polling_interval = options[:polling_interval] || 1.second
    @batch_size = options[:batch_size] || 10
    @logger = Rails.logger
    @logger = ActiveSupport::Logger.new $stdout
    @logger.level = Logger::DEBUG
    @running = false
    @worker = nil
    @dispatcher = nil
    
    setup_signal_handlers
  end
  
  def start
    @logger.info "Starting simple SolidQueue worker for queues: #{@queues.join(', ')}"
    @running = true
    
    # Use SolidQueue's built-in job execution if available
    if defined?(SolidQueue::Worker)
      @logger.info "Using SolidQueue::Worker"
      @logger.info "Using SolidQueue::Worker and SolidQueue::Dispatcher"
      
      # Start dispatcher to handle scheduled jobs
      @dispatcher = SolidQueue::Dispatcher.new(
        polling_interval: @polling_interval,
        batch_size: @batch_size
      )
      
      # Start both dispatcher and worker in separate threads
      dispatcher_thread = Thread.new do
        begin
          @logger.info "Starting dispatcher..."
          @dispatcher.start
        rescue => e
          @logger.error "Dispatcher thread error: #{e.message}"
        end
      end

      @worker = SolidQueue::Worker.new(queues: @queues.join(','))
      
      # Start the worker in a separate thread
      worker_thread = Thread.new do
        begin
          @worker.start
        rescue => e
          @logger.error "Worker thread error: #{e.message}"
        end
      end
      
      # Monitor for job completion
      monitor_and_stop_when_done(worker_thread, dispatcher_thread)
      
    else
      @logger.info "Using custom SolidQueue executor"
      # Fallback to our custom implementation - run once
      executor = SolidQueueJobExecutor.new(
        queue_names: @queues,
        polling_interval: @polling_interval,
        batch_size: @batch_size
      )
      executor.process_ready_jobs
    end
  end
  
  def stop
    @logger.info "Stopping simple worker..."
    @running = false
    
    # Stop the SolidQueue worker if it exists
    if @worker && @worker.respond_to?(:stop)
      @worker.stop
    end
  end
  
  private
  
  def monitor_and_stop_when_done(worker_thread, dispatch_thread)
    # Give the worker time to start up and begin processing
    @logger.info "Waiting for worker to start up..."
    sleep(2)
    
    last_job_count = -1
    stable_count = 0
    initial_jobs = count_pending_jobs
    
    @logger.info "Initial pending jobs: #{initial_jobs}"
    
    # If there are no jobs to begin with, still give the worker a chance
    if initial_jobs == 0
      @logger.info "No initial jobs found. Giving worker 5 seconds to find any jobs..."
      sleep(5)
    end
    
    while @running
      # Check how many jobs are pending
      pending_jobs = count_pending_jobs
      
      @logger.debug "Pending jobs: #{pending_jobs}"
      
      if pending_jobs == 0
        if last_job_count == 0
          stable_count += 1
        else
          stable_count = 1
        end
        
        # If no jobs for 3 consecutive checks, stop
        if stable_count >= 3
          @logger.info "No pending jobs found for #{stable_count} checks. Stopping worker."
          stop
          break
        end
      else
        stable_count = 0
      end
      
      last_job_count = pending_jobs
      sleep(@polling_interval)
    end
    
    @logger.info "Stopping worker thread"
    @worker.stop
    @dispatcher.stop
    wait_for_pid(@worker.pid)
    wait_for_pid(@dispatcher.pid)

    worker_thread.join(5) if(worker_thread.alive?)
    dispatch_thread.join(5) if(dispatch_thread.alive?)
    exit(0)
  end
 
  def wait_for_pid(_pid)
    @logger.info "Waiting for pid #{_pid}"
    begin
      status  = Process.waitpid(_pid)
      @logger.info "Status #{status.inspect?}"
    rescue Errno::ECHILD => e
      @logger.info "Process has already exited"
    end
  end
  
  def count_pending_jobs
    SolidQueue::Job.where(
      queue_name: @queues,
      finished_at: nil
    ).where(
      'scheduled_at IS NULL OR scheduled_at <= ?', Time.current
    ).count
  rescue => e
    @logger.error "Error counting pending jobs: #{e.message}"
    0
  end
  
  def setup_signal_handlers
    %w[TERM INT].each do |signal|
      Signal.trap(signal) { stop }
    end
  end
end

# CLI Interface
if __FILE__ == $0
  require 'optparse'
  
  options = {}
  use_simple_worker = true
  
  OptionParser.new do |opts|
    opts.banner = "Usage: #{$0} [options]"
    
    opts.on('-q', '--queues QUEUE1,QUEUE2', Array, 'Comma-separated list of queue names') do |queues|
      options[:queue_names] = queues
    end
    
    opts.on('-i', '--interval SECONDS', Float, 'Polling interval in seconds (default: 1.0)') do |interval|
      options[:polling_interval] = interval
    end
    
    opts.on('-b', '--batch-size SIZE', Integer, 'Number of jobs to process per batch (default: 10)') do |batch_size|
      options[:batch_size] = batch_size
    end
    
    opts.on('-w', '--worker-name NAME', 'Worker name identifier') do |worker_name|
      options[:worker_name] = worker_name
    end

    opts.on('-d', '--debug', 'Enable debug logging') do
      options[:debug] = true
    end
    
    opts.on('-h', '--help', 'Show this help message') do
      puts opts
      exit
    end
  end.parse!
  
  # Set log level
  if options[:debug]
    Rails.logger.level = Logger::DEBUG
  end
  
  # Validate Rails environment
  unless defined?(Rails) && Rails.application
    puts "Error: Rails application not found. Make sure to run this script from your Rails app directory."
    exit 1
  end
  
  # Check if SolidQueue is available
  unless defined?(SolidQueue)
    puts "Error: SolidQueue not found. Make sure SolidQueue is installed and configured."
    exit 1
  end
  
  puts "SolidQueue version: #{SolidQueue::VERSION}" if defined?(SolidQueue::VERSION)
  worker = SolidQueueSimpleWorker.new(options)
  
  begin
    worker.start
  rescue Interrupt
    puts "\nShutting down gracefully..."
  end
end