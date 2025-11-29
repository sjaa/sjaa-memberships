class MembersSyncJob < ApplicationJob
  queue_as :default
  include JobsHelper
  
  # MembersSyncJob.perform
  #   arg[0] - proxy user for accessing members group (e.g. vp@sjaa.net).  This must be an Admin account.
  #
  # Use the proxy user to access the members groups, and update the group to match
  # the membership status of people in the membership database.
  def perform(*args)
    puts "MemberSyncJob.args #{args.inspect}"

    # Use VP's credentials to access members group
    admin = Admin.find_by(email: args[0])

    if(admin&.refresh_token&.nil?)
      puts "[E] The input proxy user (#{args[0]}) could not be found or has not authenticated with Google.  Please use the Google Auth page to grant access to the admin's google account."
      return
    end

    auth = get_auth(admin)
    diff = sync(auth: auth, use_remove_group: true, admin_email: admin.email)

    puts "[I] People not in the members group that should be: #{diff[:umatched_people].inspect}"
    puts "[I] People in the members group that should not be: #{diff[:group_unmatched].inspect}"
    puts "[I] Added #{diff[:umatched_people].size} people and removed #{diff[:group_unmatched].size} people"
  end # perform
  
end

