Expense manager
===============

[![Build Status](https://travis-ci.org/bluerogue251/expense_manager.svg?branch=master)](https://travis-ci.org/bluerogue251/expense_manager)
[![Code Climate](https://codeclimate.com/github/bluerogue251/expense_manager/badges/gpa.svg)](https://codeclimate.com/github/bluerogue251/expense_manager)
[![Coverage Status](https://coveralls.io/repos/bluerogue251/expense_manager/badge.png)](https://coveralls.io/r/bluerogue251/expense_manager)

This is a Ruby-on-Rails application for tracking company expenses. The code is open source on [GitHub](https://github.com/bluerogue251/expense_manager), and there is a live demo on [Heroku](http://expensemanager.teddywidom.com). Here are some interesting aspects:

## The facade pattern
The dashboard shows users several pieces of loosely related data together. Instead of reaching across many different models from the controller or view, I created [a new object](https://github.com/bluerogue251/expense_manager/blob/master/app/models/dashboard.rb) to serve as a single interface (or "Facade") to all the data that is displayed in the view. This makes it possible to access data from a complex API while keeping the [controller simple](https://github.com/bluerogue251/expense_manager/blob/master/app/controllers/dashboard_controller.rb) and the logic [easy to test](https://github.com/bluerogue251/expense_manager/blob/master/spec/models/dashboard_spec.rb).

## Scalable spreadsheet-like searching and sorting
Users can search and sort large amounts of data (the demo has over 200,000 records) with online "spreadsheets". [`app/models/user_expense_search`](https://github.com/bluerogue251/expense_manager/blob/master/app/models/user_expense_search.rb) and [`app/models/datatable`](https://github.com/bluerogue251/expense_manager/blob/master/app/models/datatable.rb) are responsible for returning JSON compatible with the DataTables.js API, while using Sunspot for searching and ordering.

Sunspot auto-indexes expenses after they are saved or deleted. In addition, I added a [mixin module](https://github.com/bluerogue251/expense_manager/blob/master/app/models/concerns/reindex_expenses_after_save.rb) to the related `User`, `Department`, and `JobTitle` classes. Whenever a record changes, the module creates a [simple background job](https://github.com/bluerogue251/expense_manager/blob/master/app/models/expense_reindexer.rb) to reindex their associated expenses.

## Date-based SQL joins
Rails is great at joining records by integer foreign keys. But sometimes, other kinds of joins are necessary for a DRY, normalized database design.

When displaying sums of expenses converted into a single currency, [the `Expense` model](https://github.com/bluerogue251/expense_manager/blob/master/app/models/expense.rb) joins expenses to exchange rates through a combination of currencies and date ranges, rather than through an integer id. See `self.sum_in(currency)` and `self.joins_exchange_rates(currency)`.

To ensure each expense is joined to exactly one exchange rate, I used [Postgres check constraints](https://github.com/bluerogue251/expense_manager/blob/master/db/migrate/20140825191732_add_exchange_rate_date_range_constraint.rb) with `daterange` data types and the "`&&`" overlap operator to prevent records with overlapping currencies and date ranges from being created. Since financial data is at stake, I wrote this validation in the database rather than in ActiveRecord, so that it cannot be easily bypassed.

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
