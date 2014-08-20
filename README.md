Expense manager
===============

[![Build Status](https://travis-ci.org/bluerogue251/expense_manager.svg?branch=master)](https://travis-ci.org/bluerogue251/expense_manager)


This is a Ruby-on-Rails application for tracking company expenses. Here are some interesting facts about it:

## Scalable spreadsheet-like searching and sorting
This app integrates datatables.js on the client-side with Sunspot searching and sorting on the server-side. Users interact with online denormalized "spreadsheets" that can crunch much more data, much faster, than traditional desktop spreadsheet programs. The demo app currently has over 200,000 records, yet searching and sorting is still lightning-fast.

I found Sunspot to be easier to set up than the other potential solution, materialized views and Postgres full text search.

## Thoughtbot-oriented programming
In writing this app, I learned about and used as many of Thoughtbot's open source tools as I could. I started from scratch by running their laptop script to set up a brand new unix user, used suspenders, and stuck with most of their default gems. Thoughtbot is a great Rails product shop, so this was a chance to broaden my horizons and improve my own skills by following their lead.

## Time-interval-based SQL joins
Rails is great at joining records that are related by integer foreign keys. But sometimes, other kinds of joins are necessary for a DRY, normalized database design.

This app relates expenses to exchange rates by a combination of the expense's currency and date, instead of with an `exchange_rate_id`.

For instance, in this app, expenses have a currency and a date which relates them to an exchange rate -- they do not have an `exchange_rate_id`. Expenses can be entered in any currency. When their sums are calculated, the application calculates the conversion of all expenses to the current user's default currency before displaying it.


Getting started
---------------
It comes equipped with a self-setup script:

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

The MIT license. See LICENSE.txt
