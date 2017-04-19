# PaperLess [![Code Climate](https://codeclimate.com/github/silvio-galli/paperless/badges/gpa.svg)](https://codeclimate.com/github/silvio-galli/paperless)

**Web based app to manage products, customers' data and customers' orders in a local shop.**

Final capstone project at [Bloc](http://www.bloc.io) before graduating.

[Demo available here]() on Heroku platform.

The source code is on [GitHub](https://github.com) at: [https://github.com/silvio-galli/paperless](https://github.com/silvio-galli/paperless)

[Skip to Tech specs](#tech-specs)

## Features

### Users
We assume that:
 1. users are employees in the shop;
 2. users do not have email address;
 3. only `admin` user can create new users;
 4. only `admin` user can import products from CSV file.

### Products
We assume that:
 1. products must have 


## Tech specs
The project is based on **Ruby on Rails**, uses **Bootstrap** for the layout and other elements on the page.

**Database seeding** is obtained using the [Faker](https://github.com/stympy/faker) gem.

The project makes also use of the [jquery-barcode](http://barcode-coder.com/en/barcode-jquery-plugin-201.html) javascript library to insert products' barcode on the order page to easily pass the product at the counter.

**Environment variables and keys** are managed with the help of [Figaro](https://github.com/laserlemon/figaro) gem.

**Authentication** is managed through the [Devise](https://github.com/plataformatec/devise) gem.

**Authorization** is not implemented yet.  
There's only a [`require_admin`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/application_controller.rb) method in the `ApplicationController` class to prevent non admin users to access users' resources. It is called in [`Admin::UsersController`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/admin/users_controller.rb) and [`Admin::DashboardController`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/admin/dashboard_controller.rb) (where `admin` users can manage _standard_ users) and inside [`RegistrationsController`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/registrations_controller.rb) to prevent _standard_ users to create new users (only `admin` users are allowed to).

**Background jobs** are managed using the [Sidekiq](https://github.com/mperham/sidekiq) gem.  
The applications uses two jobs:
1. [`ImportProductsFromCsvJob`](https://github.com/silvio-galli/paperless/blob/master/app/jobs/import_products_from_csv_job.rb) to import products into the database from a CSV file.
2. [`SendEmailNotificationJob`](https://github.com/silvio-galli/paperless/blob/master/app/jobs/send_email_notification_job.rb) to email customers when their product arrive.

**Pagination** is implemented through [will_paginate](https://github.com/mislav/will_paginate) gem.

**Changes on orders** are tracked using the [PaperTrail](https://github.com/airblade/paper_trail) gem.  
When dealing with customers' order it is possible to encounter problems and it could be useful to understand where and why the order processing stuck. Tracking changes on orders can be useful to approach possible problems.

**Localization**: English/Italian

---

###### mentioned gems
![](https://img.shields.io/badge/rails-4.2.5-green.svg?style=flat)
![](https://img.shields.io/badge/bootstrap_sass-3.3.5.1-green.svg?style=flat)
![](https://img.shields.io/badge/faker-1.6.3-green.svg?style=flat)
![](https://img.shields.io/badge/jquery_rails-4.0.5-green.svg?style=flat)
![](https://img.shields.io/badge/figaro-1.1.1-green.svg?style=flat)
![](https://img.shields.io/badge/devise-3.5.6-green.svg?style=flat)
![](https://img.shields.io/badge/sidekiq-4.1.4-green.svg?style=flat)
![](https://img.shields.io/badge/will_paginate-3.1.0-green.svg?style=flat)
![](https://img.shields.io/badge/papertrail-5.2.0-green.svg?style=flat)
