# Overview

# Design

## Models

```sh
./bin/rails g scaffold person first_name:string last_name:string astrobin_id:integer:index notes:string discord_id:string referral_id:integer

./bin/rails g scaffold city name:string

./bin/rails g scaffold donation date:datetime value:decimal note:string person_id:integer:index

./bin/rails g scaffold astrobin username:string latest_image:integer

./bin/rails g scaffold membership start:datetime term_months:integer ephemeris:boolean new:boolean type:string status_id:integer person_id:integer:index

./bin/rails g scaffold status name:string short_name:string

./bin/rails g scaffold contact address:string city_id:integer state_id:integer zipcode:string phone:string email:string primary:boolean person_id:integer:index

./bin/rails g scaffold state name:string short_name:string

./bin/rails g scaffold group name:string short_name:string email:string

./bin/rails g scaffold equipment instrument_id:integer:index model:string person_id:integer:index

./bin/rails g scaffold instrument name:string:index

./bin/rails g scaffold interest name:string description:string

./bin/rails g scaffold referral name:string description:string
```

## Join Tables

```sh
./bin/rails g migration CreateJoinTablePeopleGroups people groups

./bin/rails g migration CreateJoinTableInterestsPeople interests people
```