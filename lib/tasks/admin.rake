namespace :admin do
  desc "Create the first admin account (EMAIL=admin@example.com PASSWORD=secret)"
  task create_first: [:environment] do
    email = ENV['EMAIL']
    password = ENV['PASSWORD']

    if email.nil? || email.empty?
      puts "\n" + "=" * 80
      puts "ERROR: EMAIL parameter is required"
      puts "=" * 80
      puts "\nUsage:"
      puts "  docker compose run --rm app bin/rails admin:create_first EMAIL=admin@sjaa.net PASSWORD=your_secure_password"
      puts "\nParameters:"
      puts "  EMAIL    - Email address for the admin account (required)"
      puts "  PASSWORD - Password for the admin account (required)"
      puts "\nExample:"
      puts "  docker compose run --rm app bin/rails admin:create_first EMAIL=vp@sjaa.net PASSWORD=MySecurePass123!"
      puts "\n" + "=" * 80 + "\n"
      exit 1
    end

    if password.nil? || password.empty?
      puts "\n" + "=" * 80
      puts "ERROR: PASSWORD parameter is required"
      puts "=" * 80
      puts "\nUsage:"
      puts "  docker compose run --rm app bin/rails admin:create_first EMAIL=admin@sjaa.net PASSWORD=your_secure_password"
      puts "\nParameters:"
      puts "  EMAIL    - Email address for the admin account (required)"
      puts "  PASSWORD - Password for the admin account (required)"
      puts "\nExample:"
      puts "  docker compose run --rm app bin/rails admin:create_first EMAIL=vp@sjaa.net PASSWORD=MySecurePass123!"
      puts "\n" + "=" * 80 + "\n"
      exit 1
    end

    # Check if any admins already exist
    if Admin.count > 0
      puts "\n" + "=" * 80
      puts "ERROR: Admin accounts already exist"
      puts "=" * 80
      puts "\nThis task can only be used to create the first admin account."
      puts "Existing admin count: #{Admin.count}"
      puts "\nTo create additional admin accounts, use the web interface at:"
      puts "  http://localhost:3000/admins/new"
      puts "\nOr use the Rails console:"
      puts "  docker compose run --rm app env RUBYOPT=\"-W0\" bin/rails console"
      puts "\n" + "=" * 80 + "\n"
      exit 1
    end

    puts "\n" + "=" * 80
    puts "CREATE FIRST ADMIN ACCOUNT"
    puts "=" * 80
    puts "Email: #{email}"
    puts "=" * 80 + "\n"

    # Get all permissions to grant to the first admin
    permissions = Permission.all

    if permissions.empty?
      puts "⚠️  Warning: No permissions found in database."
      puts "   The admin will be created without any permissions."
      puts "   You may need to run: docker compose run --rm app bin/rails db:seed\n\n"
    end

    # Create the admin with all permissions
    admin = Admin.new(
      email: email,
      password: password,
      password_confirmation: password
    )

    # Grant all permissions to the first admin
    admin.permissions = permissions

    begin
      if admin.save
        puts "✓ Successfully created first admin account!"
        puts "\nAdmin Details:"
        puts "  Email: #{admin.email}"
        puts "  Permissions: #{admin.permissions.pluck(:name).join(', ')}"
        puts "\nYou can now log in at:"
        puts "  http://localhost:3000/login"
        puts "\n" + "=" * 80 + "\n"
      else
        puts "✗ Failed to create admin account\n\n"
        puts "Errors:"
        admin.errors.full_messages.each do |message|
          puts "  - #{message}"
        end
        puts "\n" + "=" * 80 + "\n"
        exit 1
      end
    rescue => e
      puts "✗ Unexpected error: #{e.message}"
      puts e.backtrace.join("\n")
      exit 1
    end
  end
end
