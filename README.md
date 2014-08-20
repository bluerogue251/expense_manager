Expense manager
===============

[![Build Status](https://travis-ci.org/bluerogue251/expense_manager.svg?branch=master)](https://travis-ci.org/bluerogue251/expense_manager)
[![Code Climate](https://codeclimate.com/github/bluerogue251/expense_manager/badges/gpa.svg)](https://codeclimate.com/github/bluerogue251/expense_manager)
[![Test Coverage](https://codeclimate.com/github/bluerogue251/expense_manager/badges/coverage.svg)](https://codeclimate.com/github/bluerogue251/expense_manager)

This is a Ruby-on-Rails application for tracking company expenses. The code is open source on [Github](https://github.com/bluerogue251/expense_manager), and there is a live demo on [Heroku](http://shielded-falls-2406.herokuapp.com/). Here are some interesting facts about it:


## Scalable spreadsheet-like searching and sorting
This app integrates [DataTables](http://www.datatables.net) on the client-side with [Sunspot](https://github.com/sunspot/sunspot) on the server-side to let users search and sort large amounts of data with online "spreadsheets". The demo app currently has over 200,000 records, yet searching and sorting is still lightning-fast.

I found Sunspot to be easier to set up than the other potential solution, materialized views and Postgres full text search.

## Thoughtbot-oriented programming
I learned about and used as many of [Thoughtbot's](http://thoughtbot.com/) open source tools as I could for this app. I started from scratch by running their [laptop script](https://github.com/thoughtbot/laptop) on a brand new unix user, used [suspenders](https://github.com/thoughtbot/suspenders), and stuck with most of their default gems.

Thoughtbot is a great Rails product shop, so this was a chance to broaden my horizons and improve my own code and workflow by following their example.

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
