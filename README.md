Expense manager
===============


This is a Ruby-on-Rails application for tracking company expenses. I wrote it using as much Thoughtbot software as possible, in order to get an idea of how Thoughtbot does things.

## Interesting features:

### Scalable spreadsheet-like searching and sorting
This app integrates datatables.js on the client-side with Sunspot searching and sorting on the server-side. Users interact with online "spreadsheets" that can crunch much more data, much faster, than traditional desktop spreadsheet programs. The demo app currently has over 200,000 records, yet searching and sorting is still lightning-fast.

### Time-interval-based SQL joins
Sometimes, records in an SQL database are related not by an integer foreign key, but by presence in a date range (or a combination of both).

For instance, in this app, expenses have a currency and a date which relates them to an exchange rate -- they do not have an `exchange_rate_id`.

### On-the-fly currency conversions
Expenses can be entered in any currency. When their sums are calculated, the application calculates the conversion of all expenses to the current user's default currency before displaying it.


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
