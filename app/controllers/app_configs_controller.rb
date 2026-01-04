class AppConfigsController < ApplicationController
  def index
    authorize AppConfig

    # Build a complete list of configs (existing + placeholders)
    existing_configs = AppConfig.all.index_by(&:key)

    @configs_by_category = AppConfig.all_definitions_by_category.map do |category, definitions|
      configs = definitions.map do |definition|
        existing_configs[definition[:key]] || AppConfig.new(
          key: definition[:key],
          category: definition[:category],
          description: definition[:description],
          encrypted: definition[:encrypted],
          value: nil  # Placeholder - not persisted
        )
      end
      [category, configs]
    end

    @configs_empty = AppConfig.count == 0
  end

  def edit
    # Try to find existing config, or create from definition using key param
    @config = if params[:id].to_i > 0
      AppConfig.find(params[:id])
    else
      # ID is actually a key for a placeholder config
      AppConfig.find_or_create_from_definition(params[:id])
    end

    authorize @config
  end

  def update
    @config = AppConfig.find(params[:id])
    authorize @config

    if @config.update(config_params)
      flash[:success] = "Configuration updated successfully"
      redirect_to app_configs_path
    else
      flash.now[:alert] = "Failed to update configuration"
      render :edit
    end
  end

  def seed_from_env
    authorize AppConfig
    begin
      counts = seed_all_configs

      if counts[:created] > 0 && counts[:updated] > 0
        flash[:success] = "Configuration settings seeded! Created #{counts[:created]} new config(s) and updated #{counts[:updated]} existing config(s) from environment variables/defaults."
      elsif counts[:created] > 0
        flash[:success] = "Created #{counts[:created]} configuration setting(s) from environment variables/defaults."
      elsif counts[:updated] > 0
        flash[:success] = "Updated #{counts[:updated]} configuration setting(s) from environment variables/defaults."
      else
        flash[:success] = "All #{counts[:unchanged]} configuration setting(s) already up to date."
      end
    rescue => e
      flash[:alert] = "Error seeding configurations: #{e.message}"
    end
    redirect_to app_configs_path
  end

  private

  def config_params
    params.require(:app_config).permit(:value)
  end

  def seed_all_configs
    # Create or update all configs from definitions
    created_count = 0
    updated_count = 0
    unchanged_count = 0

    AppConfig::DEFINITIONS.each do |definition|
      config = AppConfig.find_or_initialize_by(key: definition[:key])
      was_new = config.new_record?

      new_value = ENV.fetch(definition[:env], definition[:default])
      old_value = config.value

      config.value = new_value
      config.category = definition[:category]
      config.description = definition[:description]
      config.encrypted = definition[:encrypted]

      if config.save
        if was_new
          created_count += 1
        elsif old_value != new_value
          updated_count += 1
        else
          unchanged_count += 1
        end
      end
    end

    { created: created_count, updated: updated_count, unchanged: unchanged_count }
  end
end
