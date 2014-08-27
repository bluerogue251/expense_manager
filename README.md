Expense manager
===============

[![Build Status](https://travis-ci.org/bluerogue251/expense_manager.svg?branch=master)](https://travis-ci.org/bluerogue251/expense_manager)
[![Code Climate](https://codeclimate.com/github/bluerogue251/expense_manager/badges/gpa.svg)](https://codeclimate.com/github/bluerogue251/expense_manager)
[![Test Coverage](https://codeclimate.com/github/bluerogue251/expense_manager/badges/coverage.svg)](https://codeclimate.com/github/bluerogue251/expense_manager)

This is a Ruby-on-Rails application for tracking company expenses. The code is open source on [Github](https://github.com/bluerogue251/expense_manager), and there is a live demo on [Heroku](http://shielded-falls-2406.herokuapp.com/). Here are some interesting facts about it:

## The facade pattern
This app has a dashboard where several pieces of loosely related data are shown to the user all at once. Instead of reaching into and across many different models from the controller or view layer, I created a [new object called `Dashboard`](https://github.com/bluerogue251/expense_manager/blob/master/app/models/dashboard.rb). `Dashboard` is a single interface to all the data that is needed for the view. It is an example of the [Facade Pattern](http://en.wikipedia.org/wiki/Facade_pattern), because it is a simple way to access an API without the [controller or view](https://github.com/bluerogue251/expense_manager/blob/master/app/controllers/dashboard_controller.rb) needing to understand the API's implementation details.

## Scalable spreadsheet-like searching and sorting
This app integrates [DataTables](http://www.datatables.net) on the client-side with [Sunspot](https://github.com/sunspot/sunspot) on the server-side to let users search and sort large amounts of data with online "spreadsheets". The demo app currently has over 200,000 records, yet searching and sorting is still extremely fast.

Using Sunspot (or Elasticsearch, which is comparable) have several advantages over the other popular solution, Postgres full text search. First, most searches are over denormalized data. Unless you build a denormalized [materialized view](http://bluerogue251.wordpress.com/2014/03/23/354/), it can be difficult to use indexes to ensure maximum search speed in Postgres. Second, the Sunspot API is in Ruby, and is overall easier and faster to learn. Using Sunspot, you can get started without understanding the details of things like Postgres tsvectors, gin indexes, etc.

Sunspot does require that an additional worker process run alongside your application, but for many cases, it is still a simpler and more performant solution than Postgres full text search.


## Time-interval-based SQL joins
Rails is great at joining records that are related by integer foreign keys. But sometimes, other kinds of joins are necessary for a DRY, normalized database design.

This app relates expenses to exchange rates by a combination of the expense's currency and date, instead of with an `exchange_rate_id`.

Getting started
---------------
expense_manager comes equipped with a self-setup script:

    % ./bin/setup

After setting up, you can run the application using [foreman]:

    % foreman start

[foreman]: http://ddollar.github.io/foreman/

Guidelines
----------

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)

License
-------

The MIT License. See [LICENSE.txt](https://github.com/bluerogue251/expense_manager/blob/master/LICENSE.txt)
