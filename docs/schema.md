# Schema Information (TBD)

## Note
Catarse was originally created in an earlier version of Rails, and so it does not have a schema.rb. There are ~300 migrations and a lot of libraries that are storing information in the database.

Because it's a nontrivial task to get Catarse running with all of its dependencies, I'm not yet able to set up the database and inspect the schema. A schema of the database will be forthcoming after I inspect and come to understand the way it's structured.

Due to the quantity of libraries and inter-dependencies, it's also hard to predict what additions I'll have to make to the schema to fully wire it up with Catarse. But below is a very tentative outline.

# Schema

## organizations
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
charity_id  | integer   | not null, foreign key (references charities)
name        | string    | not null

(+ page formatting details and fundraising details)

## organization admins
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
admin_id    | integer   | not null, foreign key (references users)
org_id      | integer   | not null, foreign key (references organizations)
blog_id     | integer   | not null, foreign key (references blogs)

## charities
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
org_id      | integer   | not null, foreign key (references organization)
name        | string    | not null

(+ payment information, tax information, etc.)

## donations (currently "payments"; will have to rework schema)
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
fund_id     | integer   | not null, foreign key (references fundraisers)
charity_id  | integer   | not null, foreign key (references charities)
donor_id    | integer   | foreign key (references users)
amount      | float     | not null
currency    | string    | not null, default: "USD"
comment     | varchar(1000) |

## fundraisers
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
charity_id  | integer   | foreign key (references charities)
creator_id  | integer   | foreign key (polymorphic)
creator_type| string    | "charity" or "user"
title       | string    | not null
category    | string    | not null
team_id     | integer   | foreign key (references teams)

## teams
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
fund_id     | integer   | foreign key (references fundraisers)
name        | string    | not null


## team memberships
column name | data type | details
------------|-----------|-----------------------
id          | integer   | not null, primary key
user_id     | integer   | not null, foreign key (references users)
team_id     | integer   | not null, foreign key (references teams)
