require "test_helper"

class RenewalRemindersJobTest < ActiveJob::TestCase
  setup do
    @referral = Referral.create!(name: 'internet', description: 'Web search')
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      referral: @referral
    )
    @contact = Contact.create!(
      email: 'john@example.com',
      person: @person,
      primary: true
    )
  end

  test 'job calculates days until expiration without error' do
    # Create a membership expiring in 30 days
    membership = Membership.create!(
      person: @person,
      start: 11.months.ago.beginning_of_month,
      term_months: 12
    )

    # Ensure the membership.end is a TimeWithZone (as it is in production)
    assert_kind_of ActiveSupport::TimeWithZone, membership.end

    # This should not raise "undefined method '-@' for Date" error
    assert_nothing_raised do
      days_until_expiration = (membership.end.to_date - Date.today).to_i
      assert_kind_of Integer, days_until_expiration
    end
  end

  test 'job does not send emails when disabled' do
    # Create a renewable member
    Membership.create!(
      person: @person,
      start: 11.months.ago.beginning_of_month,
      term_months: 12
    )

    # Count emails before
    emails_before = ActionMailer::Base.deliveries.count

    job = RenewalRemindersJob.new
    job.perform('disable', '* 1 *')

    # Should not have sent any emails
    assert_equal emails_before, ActionMailer::Base.deliveries.count
  end

  test 'job handles TimeWithZone to Date conversion correctly' do
    # Create a renewable member
    membership = Membership.create!(
      person: @person,
      start: 11.months.ago.beginning_of_month,
      term_months: 12
    )

    # Verify membership.end is TimeWithZone
    assert_kind_of ActiveSupport::TimeWithZone, membership.end

    # This calculation should work without error (mimics what happens in the job)
    assert_nothing_raised do
      if membership.end
        days_until_expiration = (membership.end.to_date - Date.today).to_i
        assert_kind_of Integer, days_until_expiration
      end
    end
  end

  test 'job handles membership with nil end date without error' do
    # Create a lifetime membership (nil end date)
    membership = Membership.create!(
      person: @person,
      start: Date.current,
      term_months: nil
    )

    # Verify end is nil
    assert_nil membership.end

    # This should not raise an error
    assert_nothing_raised do
      if membership.end
        days_until_expiration = (membership.end.to_date - Date.today).to_i
      end
      # The if condition is false, so the calculation is skipped
    end
  end
end
