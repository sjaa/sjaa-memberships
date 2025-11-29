require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  setup do
    @referral = Referral.create!(name: 'internet', description: 'Web search')
    @person = Person.create!(
      first_name: 'John',
      last_name: 'Doe',
      password: 'password123',
      referral: @referral
    )
    @contact = Contact.create!(
      email: 'test@example.com',
      person: @person,
      primary: true
    )
  end

  test 'valid contact with required attributes' do
    contact = Contact.new(
      email: 'valid@example.com',
      person: @person,
      primary: false
    )
    assert contact.valid?
  end

  test 'contact requires email' do
    contact = Contact.new(
      person: @person,
      primary: false
    )
    assert_not contact.valid?
    assert_includes contact.errors[:email], "can't be blank"
  end

  test 'contact requires person' do
    contact = Contact.new(
      email: 'test@example.com',
      primary: false
    )
    assert_not contact.valid?
    assert_includes contact.errors[:person], "must exist"
  end

  # Email uniqueness tests with case-insensitivity and whitespace handling
  test 'duplicate email with exact same case is invalid' do
    duplicate_contact = Contact.new(
      email: 'test@example.com',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with different capitalization is invalid' do
    duplicate_contact = Contact.new(
      email: 'TEST@EXAMPLE.COM',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with mixed case is invalid' do
    duplicate_contact = Contact.new(
      email: 'TeSt@ExAmPlE.cOm',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with leading whitespace is invalid' do
    duplicate_contact = Contact.new(
      email: '  test@example.com',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with trailing whitespace is invalid' do
    duplicate_contact = Contact.new(
      email: 'test@example.com  ',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with leading and trailing whitespace is invalid' do
    duplicate_contact = Contact.new(
      email: '  test@example.com  ',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with whitespace and different case is invalid' do
    duplicate_contact = Contact.new(
      email: '  TEST@EXAMPLE.COM  ',
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'duplicate email with tabs is invalid' do
    duplicate_contact = Contact.new(
      email: "\ttest@example.com\t",
      person: @person,
      primary: false
    )
    assert_not duplicate_contact.valid?
    assert_includes duplicate_contact.errors[:email], "has already been taken"
  end

  test 'email is normalized to lowercase after validation' do
    contact = Contact.create!(
      email: 'UPPERCASE@EXAMPLE.COM',
      person: @person,
      primary: false
    )
    assert_equal 'uppercase@example.com', contact.email
  end

  test 'email whitespace is stripped after validation' do
    contact = Contact.create!(
      email: '  whitespace@example.com  ',
      person: @person,
      primary: false
    )
    assert_equal 'whitespace@example.com', contact.email
  end

  test 'email whitespace and case are both normalized' do
    contact = Contact.create!(
      email: '  MiXeD@EXAMPLE.com  ',
      person: @person,
      primary: false
    )
    assert_equal 'mixed@example.com', contact.email
  end

  # Test through person model to ensure validation propagates
  test 'person update with duplicate email shows error' do
    person2 = Person.create!(
      first_name: 'Jane',
      last_name: 'Smith',
      password: 'password123',
      referral: @referral
    )

    Contact.create!(
      email: 'jane@example.com',
      person: person2,
      primary: true
    )

    person2.reload  # Reload to get contacts association

    # Try to update person2 with duplicate email
    result = person2.update(
      contact_attributes: [
        { id: person2.contacts.first.id, email: 'test@example.com' }
      ]
    )

    assert_not result
    assert_includes person2.errors.full_messages.join(' '), 'Contact email'
    assert_includes person2.errors.full_messages.join(' '), 'has already been taken'
  end

  test 'person update with duplicate email in different case shows error' do
    person2 = Person.create!(
      first_name: 'Jane',
      last_name: 'Smith',
      password: 'password123',
      referral: @referral
    )

    Contact.create!(
      email: 'jane@example.com',
      person: person2,
      primary: true
    )

    person2.reload  # Reload to get contacts association

    # Try to update with duplicate email in different case
    result = person2.update(
      contact_attributes: [
        { id: person2.contacts.first.id, email: 'TEST@EXAMPLE.COM' }
      ]
    )

    assert_not result
    assert_includes person2.errors.full_messages.join(' '), 'Contact email'
    assert_includes person2.errors.full_messages.join(' '), 'has already been taken'
  end

  test 'person update with duplicate email with whitespace shows error' do
    person2 = Person.create!(
      first_name: 'Jane',
      last_name: 'Smith',
      password: 'password123',
      referral: @referral
    )

    Contact.create!(
      email: 'jane@example.com',
      person: person2,
      primary: true
    )

    person2.reload  # Reload to get contacts association

    # Try to update with duplicate email with whitespace
    result = person2.update(
      contact_attributes: [
        { id: person2.contacts.first.id, email: '  test@example.com  ' }
      ]
    )

    assert_not result
    assert_includes person2.errors.full_messages.join(' '), 'Contact email'
    assert_includes person2.errors.full_messages.join(' '), 'has already been taken'
  end
end
