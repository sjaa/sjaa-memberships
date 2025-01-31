# Overview

This app is designed to help manage membership data for administrative and application use cases.  The primary goal is to provide a secure way to access and edit information about the SJAA membership.  This is accomplished with an authentication system that allows for admins with different permissions to do different things within the app.  Admins need read permission to view any member data, for example.  They need write permissions to update any data, and they need additional permissions to manage the permissions themselves.  All of the data is accessible securely through a front-end UI, or through a secure API.

# Database

The data model in this app allows us to store a lot more robust and accurate information about our membership than a spreadsheet.  This app can store:

* All members of SJAA throughout history
* Many different reported interests of each member
* Many different contact addresses, phone numbers, emails, etc per person
* The current standing of any given person
* When each time a person signed up or renewed their membership, for how long, and when that membership expired
* The full donation history for a member, including the date and amount of each donation
* All the equipment a person reports as hanving, orgainzed into individual, queryable instruments
* What groups and roles within the organization a person belongs to (i.e. "Observers List" or "Vice-President")
* Any linked accounts, such as Discord or Astrobin

All of this data is also structured so as to maximize data integrity, unlike a spreadsheet, where typos can make it hard to get accurate query results.

# Use Cases

The app should serve as a secure store for the membership data, and should facilitate a variety of use cases:

1. Lookup a person's membership status
    ```ruby
    # By name
    Person.find_by(last_name: 'Svensson').status.name
    => "member"

    # By email
    Person.joins(:contacts).where(contact: {email: 'csvenss2@gmail.com'}).first.status.name
    => "member"
    ```
1. Get a person's contact information
    ```ruby
    Person.find_by(last_name: 'Svensson').contacts
    => 
    [#<Contact:0x0000ffff80a67220
      id: 126,
      address: "123 Fake St",
      city_id: 5,
      state_id: 1,
      zipcode: "95555",
      phone: "123-456-7890",
      email: "jorge.conseco@att.net",
      primary: true,
      person_id: 126]
    ```
1. Lookup the donation history for any given member
    ```ruby
    Person.find_by(id: 42).donations
    ```
2. Lookup a person's membership renewal history
    ```ruby
    Person.find_by(id: 42).memberships
    ```
2. Lookup when a person first joined
    ```ruby
    Person.find_by(id: 42).memberships.order(start: :asc).first.start
    => Sat, 21 Sep 2019 00:00:00.000000000 UTC +00:00
    ```
1. Lookup when a person's membership expires
    ```ruby
    membership = Person.find_by(id: 42).memberships.order(start: :desc).first
    expiration = membership.start + membership.term_months.months
    => Mon, 24 Nov 2025 00:00:00.000000000 UTC +00:00
    ```
1. Find members whose memberships have lapsed
    ```ruby
    # All expired memberships
    Person.lapsed_members

    # Expired memberships who still have the "member" standing
    Person.lapsed_members(status: 'member')
    ```
  
# Reporting

The structured nature of this data should make it suitable for generating various reports that can be featured in the app.

# API

## CREATE API Key

* **Method** `POST`
* **URL** ` /api-keys`
* **Header** `Authorization: Basic base64(username:password)`
* **Response**
    ```json
    {"token":"065d0689cdde5c0959d92bae9f3ccde9","permissions":["read","write","permit"]}
    ```
Use this endpoint to create a new API key for a given account.  The string following "Basic" in the header should be the base64-encoded string of `username:password` - whatever your usename (email) and password are.  The response contains your token and a summary of the permissions associated with that token.

## List API Keys

* **Method** `GET`
* **URL** ` /api-keys`
* **Header** `Authorization: Bearer token`
* **Response**
    ```json
    [
      {
        "permissions": [
          "read",
          "write",
          "permit"
        ],
        "token": "75b7b6b26ce1fcefabc0176bc093519f"
      },
      {
        "permissions": [
          "read",
          "write",
          "permit"
        ],
        "token": "445e48c364f577adb9d1635005cf5731"
      },
      ...
    ]
    ```
Use this endpoint to list all API keys associated with a bearer.  Requires an API key for authorizationS

## Revoke API Keys

* **Method** `DELETE`
* **URL** ` /api-keys`
* **Header** `Authorization: Bearer token`
* **Response**
    ```json
    ```
Use this endpoint to revoke (delete) the api key that is passed in via the header.  On success, no response is returned.

## Person lookup by id


```json
{
  "astrobin": {
    "created_at": "2025-01-07T06:56:55.040Z",
    "id": 22,
    "latest_image": 11664,
    "updated_at": "2025-01-07T06:56:55.040Z",
    "username": "ut"
  },
  "created_at": "2025-01-07T06:56:55.044Z",
  "discord_id": null,
  "donations": [
    {
      "created_at": "2025-01-07T06:56:55.077Z",
      "date": "2019-12-10T00:00:00.000Z",
      "id": 202,
      "note": "Placeat fuga a magni.",
      "person_id": 42,
      "updated_at": "2025-01-07T06:56:55.077Z",
      "value": "633.0"
    },
    {
      "created_at": "2025-01-07T06:56:55.079Z",
      "date": "2005-04-13T00:00:00.000Z",
      "id": 203,
      "note": "Quo ipsam accusamus libero.",
      "person_id": 42,
      "updated_at": "2025-01-07T06:56:55.079Z",
      "value": "574.0"
    }
  ],
  "first_name": "Nichol",
  "groups": [],
  "id": 42,
  "last_name": "Nolan",
  "memberships": [
    {
      "created_at": "2025-01-07T06:56:55.048Z",
      "ephemeris": false,
      "id": 284,
      "kind": "LIFETIME",
      "new": false,
      "person_id": 42,
      "start": "2005-09-04T00:00:00.000Z",
      "term_months": 12,
      "updated_at": "2025-01-07T06:56:55.048Z"
    },
    {
      "created_at": "2025-01-07T06:56:55.055Z",
      "ephemeris": false,
      "id": 287,
      "kind": null,
      "new": true,
      "person_id": 42,
      "start": "2012-05-22T00:00:00.000Z",
      "term_months": 12,
      "updated_at": "2025-01-07T06:56:55.055Z"
    },
    {
      "created_at": "2025-01-07T06:56:55.058Z",
      "ephemeris": false,
      "id": 288,
      "kind": null,
      "new": false,
      "person_id": 42,
      "start": "2013-11-14T00:00:00.000Z",
      "term_months": 12,
      "updated_at": "2025-01-07T06:56:55.058Z"
    },
    {
      "created_at": "2025-01-07T06:56:55.046Z",
      "ephemeris": false,
      "id": 283,
      "kind": "VB-M",
      "new": false,
      "person_id": 42,
      "start": "2019-07-07T00:00:00.000Z",
      "term_months": 12,
      "updated_at": "2025-01-07T06:56:55.046Z"
    },
    {
      "created_at": "2025-01-07T06:56:55.053Z",
      "ephemeris": true,
      "id": 286,
      "kind": null,
      "new": true,
      "person_id": 42,
      "start": "2022-01-13T00:00:00.000Z",
      "term_months": 12,
      "updated_at": "2025-01-07T06:56:55.053Z"
    },
    {
      "created_at": "2025-01-07T06:56:55.051Z",
      "ephemeris": false,
      "id": 285,
      "kind": null,
      "new": false,
      "person_id": 42,
      "start": "2023-01-23T00:00:00.000Z",
      "term_months": 12,
      "updated_at": "2025-01-07T06:56:55.051Z"
    }
  ],
  "notes": "Neither a borrower nor a lender be; For loan oft loses both itself and friend, and borrowing dulls the edge of husbandry.",
  "referral": {
    "created_at": "2025-01-07T06:56:51.158Z",
    "description": "Web search",
    "id": 1,
    "name": "internet",
    "updated_at": "2025-01-07T06:56:51.158Z"
  },
  "updated_at": "2025-01-07T06:56:55.044Z",
  "url": "https://127.0.0.1:3001/people/42.json"
}
```

# Deployment

A few notes for various deployment options

## Heroku

```sh
git push heroku main # deploy
heroku run bash # get a shell
heroku run rake db:schema:load # setup gives a permission error
heroku run rake db:seed
heroku pg:reset # to drop the database
```

## To Do

* E-mail views
* Forgot/Generate password flow
* Membership Dues Payment Flow
* New Member flow
* Equipment transfers

## Mail
Setting up mail in a Rails application is straightforward, but it does involve a few steps. Here's a step-by-step guide to get you started:

1. **Install the `mail` gem**: Rails comes with Action Mailer, but you'll want to make sure the `mail` gem is included in your `Gemfile`.
    ```ruby
    gem 'mail'
    ```

2. **Set up the Mailer**: Generate a mailer using the Rails generator.
    ```sh
    rails generate mailer UserMailer
    ```
    This will create a mailer file (`app/mailers/user_mailer.rb`) and corresponding views for your mail templates.

3. **Configure your mail settings**: In your environment configuration file (e.g., `config/environments/development.rb`), set up your mailer configuration. For example, if you're using Gmail, it might look like this:
    ```ruby
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtp.gmail.com',
      port:                 587,
      domain:               'yourdomain.com',
      user_name:            '<your_email>@gmail.com',
      password:             '<your_email_password>',
      authentication:       'plain',
      enable_starttls_auto: true
    }
    ```

4. **Define your mailer methods**: In `app/mailers/user_mailer.rb`, define the methods to send emails. For example:
    ```ruby
    class UserMailer < ApplicationMailer
      default from: 'notifications@example.com'

      def welcome_email(user)
        @user = user
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'Welcome to My Awesome Site')
      end
    end
    ```

5. **Create email views**: In `app/views/user_mailer`, create the HTML and text templates for your emails. For example, `welcome_email.html.erb` and `welcome_email.text.erb`.

6. **Send the email**: Call the mailer method from your controller or background job. For example:
    ```ruby
    UserMailer.welcome_email(@user).deliver_now
    ```

Here's an example of how it all fits together:

```ruby
# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end
end
```

Great question! Testing mail views ensures that your emails look right before sending them out to users. Here’s how you can test mail views in a Rails application:

### 1. **Use Preview Classes**

Rails provides a convenient way to preview emails in the browser using preview classes. Here’s how to set it up:

1. **Create a Mailer Preview**: In your `test/mailers/previews` directory, create a preview file for your mailer (e.g., `user_mailer_preview.rb`).

    ```ruby
    # test/mailers/previews/user_mailer_preview.rb
    class UserMailerPreview < ActionMailer::Preview
      def welcome_email
        user = User.first
        UserMailer.welcome_email(user)
      end
    end
    ```

2. **Access the Preview**: Start your Rails server and navigate to `/rails/mailers/user_mailer/welcome_email` in your browser to see the email preview.

### 2. **RSpec Testing**

If you’re using RSpec for testing, you can also write tests for your mailers. Here’s an example:

1. **Install RSpec**: If you haven’t already, add RSpec to your `Gemfile` and install it.
    ```ruby
    gem 'rspec-rails'
    ```

2. **Generate RSpec Mailer Specs**: Generate the spec file for your mailer.
    ```sh
    rails generate rspec:mailer UserMailer
    ```

3. **Write the Tests**: In your generated mailer spec file (e.g., `spec/mailers/user_mailer_spec.rb`), write your tests.

    ```ruby
    require "rails_helper"

    RSpec.describe UserMailer, type: :mailer do
      describe 'welcome_email' do
        let(:user) { create(:user) }
        let(:mail) { UserMailer.welcome_email(user) }

        it 'renders the headers' do
          expect(mail.subject).to eq('Welcome to My Awesome Site')
          expect(mail.to).to eq([user.email])
          expect(mail.from).to eq(['notifications@example.com'])
        end

        it 'renders the body' do
          expect(mail.body.encoded).to match('Welcome to My Awesome Site')
        end
      end
    end
    ```

### 3. **Rails Console**

You can also use the Rails console to send emails to your development environment to see how they look.

```sh
rails console
```

```ruby
user = User.first
UserMailer.welcome_email(user).deliver_now
```

This will send the email to the address specified in your development environment.

### 4. **Local SMTP Server**

For more advanced testing, you can set up a local SMTP server like [MailCatcher](https://mailcatcher.me/) to capture and view outgoing emails.

1. **Install MailCatcher**:
    ```sh
    gem install mailcatcher
    ```

2. **Start MailCatcher**:
    ```sh
    mailcatcher
    ```

3. **Configure Rails**: In your `config/environments/development.rb`, configure Action Mailer to use MailCatcher.

    ```ruby
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'localhost',
      port: 1025
    }
    ```

4. **Send Emails**: Any email sent from your Rails app will be caught by MailCatcher. Access it via `http://localhost:1080`.

By combining these techniques, you can ensure that your mail views are perfect before sending them out to users. 

## Reset Password

Generating a "reset password" email without using Devise requires you to build your own system for handling password resets. Here's how you can do it step-by-step:

### 1. **Set Up Your User Model**

Ensure your user model has the necessary fields for handling password resets. You’ll need a token and a timestamp.

1. **Add Fields to Users**:
    ```sh
    rails generate migration add_password_reset_to_users reset_password_token:string reset_password_sent_at:datetime
    rails db:migrate
    ```

2. **Update User Model**:
    ```ruby
    class User < ApplicationRecord
      # Add validations, callbacks, and other logic as needed
    end
    ```

### 2. **Generate the Token and Timestamp**

Create methods in your User model to handle generating and setting the reset token and timestamp.

1. **User Model**:
    ```ruby
    class User < ApplicationRecord
      # Generates a unique token for password reset
      def generate_password_reset_token!
        self.reset_password_token = SecureRandom.urlsafe_base64
        self.reset_password_sent_at = Time.zone.now
        save!
      end

      # Checks if the password reset token is still valid (e.g., within 2 hours)
      def password_reset_token_valid?
        reset_password_sent_at >= 2.hours.ago
      end

      # Resets the password
      def reset_password!(new_password)
        self.password = new_password
        self.reset_password_token = nil
        save!
      end
    end
    ```

### 3. **Create the Mailer**

Set up a mailer to send the password reset email.

1. **Generate a Mailer**:
    ```sh
    rails generate mailer UserMailer
    ```

2. **Mailer Setup**:
    ```ruby
    class UserMailer < ApplicationMailer
      default from: 'no-reply@example.com'

      def password_reset(user)
        @user = user
        @url = edit_password_reset_url(user.reset_password_token)
        mail(to: @user.email, subject: 'Password Reset Instructions')
      end
    end
    ```

3. **Create Email Views**:
    Create views for your email in `app/views/user_mailer/`.

    **password_reset.html.erb**:
    ```erb
    <h1>Password Reset Instructions</h1>
    <p>
      To reset your password, click the link below:
      <a href="<%= @url %>">Reset Password</a>
    </p>
    ```

    **password_reset.text.erb**:
    ```erb
    Password Reset Instructions

    To reset your password, click the link below:
    <%= @url %>
    ```

### 4. **Controller for Password Resets**

Create a controller to handle password reset requests and token validation.

1. **Generate a Controller**:
    ```sh
    rails generate controller PasswordResets new edit create update
    ```

2. **Set Up Routes**:
    ```ruby
    Rails.application.routes.draw do
      resources :password_resets, only: [:new, :create, :edit, :update]
    end
    ```

3. **Controller Actions**:
    ```ruby
    class PasswordResetsController < ApplicationController
      def new
      end

      def create
        user = User.find_by(email: params[:email])
        if user
          user.generate_password_reset_token!
          UserMailer.password_reset(user).deliver_now
          redirect_to root_path, notice: 'Password reset email has been sent.'
        else
          flash.now[:alert] = 'Email address not found.'
          render :new
        end
      end

      def edit
        @user = User.find_by(reset_password_token: params[:id])
        if @user.nil? || !@user.password_reset_token_valid?
          redirect_to new_password_reset_path, alert: 'Password reset token is invalid or expired.'
        end
      end

      def update
        @user = User.find_by(reset_password_token: params[:id])
        if @user.update(user_params)
          @user.reset_password!(params[:user][:password])
          redirect_to root_path, notice: 'Your password has been reset!'
        else
          render :edit
        end
      end

      private

      def user_params
        params.require(:user).permit(:password, :password_confirmation)
      end
    end
    ```

### 5. **Create Views for Password Resets**

Create the necessary views in `app/views/password_resets/`.

- **new.html.erb**:
    ```erb
    <h1>Forgot Your Password?</h1>
    <%= form_with(url: password_resets_path, local: true) do |form| %>
      <div class="field">
        <%= form.label :email %>
        <%= form.email_field :email %>
      </div>
      <div class="actions">
        <%= form.submit "Reset Password" %>
      </div>
    <% end %>
    ```

- **edit.html.erb**:
    ```erb
    <h1>Reset Your Password</h1>
    <%= form_with(model: @user, url: password_reset_path(@user.reset_password_token), local: true) do |form| %>
      <div class="field">
        <%= form.label :password %>
        <%= form.password_field :password %>
      </div>
      <div class="field">
        <%= form.label :password_confirmation %>
        <%= form.password_field :password_confirmation %>
      </div>
      <div class="actions">
        <%= form.submit "Update Password" %>
      </div>
    <% end %>
    ```

By following these steps, you can implement a custom password reset feature in your Rails application without relying on Devise. If you have any further questions or need more details, feel free to ask! 🚀🔐