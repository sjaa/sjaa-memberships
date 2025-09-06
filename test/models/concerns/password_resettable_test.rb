require 'test_helper'

class PasswordResettableTest < ActiveSupport::TestCase
  class DummyModel < ApplicationRecord
    self.table_name = 'people'
    include PasswordResettable
    has_secure_password
  end

  setup do
    @model = DummyModel.new(
      first_name: 'Test',
      last_name: 'User',
      password: 'password123'
    )
    @model.save!
  end

  test 'generate_password_reset_token! creates token and timestamp' do
    assert_nil @model.reset_password_token
    assert_nil @model.reset_password_sent_at

    @model.generate_password_reset_token!

    assert_not_nil @model.reset_password_token
    assert_not_nil @model.reset_password_sent_at
    assert @model.reset_password_sent_at <= Time.zone.now
    assert @model.reset_password_sent_at >= 1.minute.ago
  end

  test 'generate_password_reset_token! creates unique tokens' do
    @model.generate_password_reset_token!
    first_token = @model.reset_password_token

    other_model = DummyModel.create!(
      first_name: 'Other',
      last_name: 'User', 
      password: 'password123'
    )
    other_model.generate_password_reset_token!

    assert_not_equal first_token, other_model.reset_password_token
  end

  test 'password_reset_token_valid? returns true for recent token' do
    @model.generate_password_reset_token!
    assert @model.password_reset_token_valid?
  end

  test 'password_reset_token_valid? returns false for old token' do
    @model.generate_password_reset_token!
    @model.update_column(:reset_password_sent_at, 3.hours.ago)
    assert_not @model.password_reset_token_valid?
  end

  test 'password_reset_token_valid? returns false when token is nil' do
    assert_not @model.password_reset_token_valid?
  end

  test 'reset_password! updates password and clears token' do
    @model.generate_password_reset_token!
    old_token = @model.reset_password_token

    @model.reset_password!('newpassword123')

    assert @model.authenticate('newpassword123')
    assert_not @model.authenticate('password123')
    assert_nil @model.reset_password_token
    assert_not_equal old_token, @model.reset_password_token
  end

  test 'reset_password! saves the model' do
    @model.generate_password_reset_token!
    @model.first_name = 'Changed'
    
    @model.reset_password!('newpassword123')
    
    @model.reload
    assert_equal 'Changed', @model.first_name
    assert @model.authenticate('newpassword123')
  end
end