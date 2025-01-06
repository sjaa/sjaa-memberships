# Overview

This app is designed to help manage membership data for administrative and application use cases.  The primary goal is to provide a secure way to access and edit information about the SJAA membership.  This is accomplished with an authentication system that allows for admins with different permissions to do different things within the app.  Admins need read permission to view any member data, for example.  They need write permissions to update any data, and they need additional permissions to manage the permissions themselves.  All of the data is accessible securely through a front-end UI, or through a secure API.

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
      email: "csvenss2@gmail.com",
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