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
heroku run rake db:migrate
heroku pg:reset # to drop the database
```

## Email

For proof-of-concept, I'm using Google's SMTP server with the vp@sjaa.net account and an app password.  Alternatives include
verified domains and an SMTP host like Mailgun.

In development, Google's SMTP server could be used, or Mailtrap, which fakes an SMTP server and prevents emails from
being delivered, but gives you a place to view the emails, through their dashboard, for debug.

## To Do

* E-mail views - Done
* Forgot/Generate password flow - Done
* Membership Dues Payment Flow
* Remove status (superceded by role)
* New Member flow
* Merge two People
* Widgets Controller
* Equipment transfers
* Admin Dashboard?
  * https://adminlte.io
* Maglev site builder?
  * Needs lots of development to be fully customizable, but has promise

## Allow Embeds

To embed a Ruby page in an iframe without using JavaScript, you'll need to ensure that your server is configured to allow the page to be embedded. Here are the steps:

### Step 1: Configure Your Server
1. **Allow Cross-Origin Requests**: Ensure that your server is configured to allow cross-origin requests. This is necessary for embedding content in an iframe from a different domain. You can do this by setting the `Access-Control-Allow-Origin` header in your server configuration. For example, in a Rails application, you can add this to your controller:
    ```ruby
    before_action :allow_cross_origin, if: :embeddable?

    def allow_cross_origin
      headers['Access-Control-Allow-Origin'] = '*'
    end

    def embeddable?
      request.headers['X-Frame-Options'].present?
    end
    ```

2. **Set X-Frame-Options**: Ensure that the `X-Frame-Options` header is set to `ALLOW-FROM` followed by the URL of the site that will embed your content. For example:
    ```ruby
    response.headers['X-Frame-Options'] = 'ALLOW-FROM https://example.com'
    ```

### Step 2: Update Your Rails Controller
1. **Create a Controller Action**: Create a controller action to serve the content you want to embed. For example, in `WidgetsController`:
    ```ruby
    class WidgetsController < ApplicationController
      def show
        # Your widget code here
      end
    end
    ```

2. **Set Content Type**: Ensure that the content type is set to `text/html` so that it can be embedded in an iframe:
    ```ruby
    class WidgetsController < ApplicationController
      def show
        response.headers['Content-Type'] = 'text/html'
        render layout: false
      end
    end
    ```

### Step 3: Embed the Content
1. **Use an Iframe**: On the embedding site, use an iframe to embed the content. For example:
    ```html
    <iframe src="https://yourapp.com/widget/show" width="600" height="400"></iframe>
    ```

By following these steps, you should be able to embed a Ruby page in an iframe without using JavaScript. Does this help clarify the process?