# PaperLess [![Code Climate](https://codeclimate.com/github/silvio-galli/paperless/badges/gpa.svg)](https://codeclimate.com/github/silvio-galli/paperless)  
![](https://img.shields.io/badge/rails-4.2.5-green.svg?style=flat) ![](https://img.shields.io/badge/bootstrap_sass-3.3.6-green.svg?style=flat) ![](https://img.shields.io/badge/faker-1.6.3-green.svg?style=flat) ![](https://img.shields.io/badge/jquery_rails-4.0.5-green.svg?style=flat) ![](https://img.shields.io/badge/figaro-1.1.1-green.svg?style=flat) ![](https://img.shields.io/badge/devise-3.5.6-green.svg?style=flat) ![](https://img.shields.io/badge/sidekiq-4.1.4-green.svg?style=flat) ![](https://img.shields.io/badge/will_paginate-3.1.0-green.svg?style=flat) ![](https://img.shields.io/badge/papertrail-5.2.0-green.svg?style=flat)

**Web based app to manage products, customers' data and customers' orders in a local shop.**

Final capstone project at [Bloc](https://www.bloc.io/users/silvio-galli) before graduating.

[Demo available here](https://warm-coast-71743.herokuapp.com) on Heroku platform.

The source code is on [GitHub](https://github.com) at: [https://github.com/silvio-galli/paperless](https://github.com/silvio-galli/paperless)

Skip to [Features](#features) | [Users](#users) | [Welcome page](#welcome) | [Products](#products) | [Customers](#customers) | [Orders](#orders)

## Tech specs
The project is based on **Ruby on Rails**, uses **Bootstrap** for the layout and other elements on the page.

**Database seeding** is obtained using the [Faker](https://github.com/stympy/faker) gem.

The project makes also use of the [jquery-barcode](http://barcode-coder.com/en/barcode-jquery-plugin-201.html) javascript library to insert products' barcode on the order page to easily pass the product at the counter.

**Environment variables and keys** are managed with the help of [Figaro](https://github.com/laserlemon/figaro) gem.

**Authentication** is managed through the [Devise](https://github.com/plataformatec/devise) gem.  
The application needed to give user creation prerogative to `admin` users only and no possibility to sign up from the outside. As Devise do not allow signed in users to access `registrations#new`, I added `before_action :require_admin` and `skip_before_action :require_no_authentication` callback and `def sign_up(resource_name, resource) true end` to [`RegistrationsController`](app/controllers/registrations_controller.rb) to allow already authenticated `admin` users to access `registrations#new` in `Devise::RegistrationsController` and avoid automatic sign in after new user creation.

**Authorization** is not implemented yet.  
There's only a [`require_admin`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/application_controller.rb) method in the `ApplicationController` class to prevent non admin users to access users' resources. It is called in [`Admin::UsersController`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/admin/users_controller.rb) and [`Admin::DashboardController`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/admin/dashboard_controller.rb) (where `admin` users can manage _standard_ users to reset their password) and inside [`RegistrationsController`](https://github.com/silvio-galli/paperless/blob/master/app/controllers/registrations_controller.rb) to prevent _standard_ users to create new users (only `admin` users are allowed to).

I implemented a simple **Search** function after watching [this screencast](https://www.codeschool.com/screencasts/basecamp-search) on [CodeSchool.com](https://www.codeschool.com/).  
The search runs on `Product` or `Customer` tables only.  
The files involved are [search.rb](app/models/search.rb), [search_controller.rb](app/controllers/search_controller.tb) and [search/index.html.rb](app/views/search/index.html.rb).

**Background jobs** are managed using the [Sidekiq](https://github.com/mperham/sidekiq) gem.  
The applications uses two jobs:
1. [`ImportProductsFromCsvJob`](https://github.com/silvio-galli/paperless/blob/master/app/jobs/import_products_from_csv_job.rb) to import products into the database from a CSV file.
2. [`SendEmailNotificationJob`](https://github.com/silvio-galli/paperless/blob/master/app/jobs/send_email_notification_job.rb) to email customers when their product arrive.

**Pagination** is implemented through [will_paginate](https://github.com/mislav/will_paginate) gem.

**Changes on orders** are tracked using the [PaperTrail](https://github.com/airblade/paper_trail) gem.  
When dealing with customers' order it is possible to encounter problems and it could be useful to understand where and why the order processing stuck. Tracking changes on orders can be useful to approach possible problems.

**Localization**: English/Italian.

---

## Features

### Users

**Landing page:**

![welcome_index_unauthenticated](https://cloud.githubusercontent.com/assets/15610747/25229134/691e719c-25cf-11e7-975b-40d68c191366.png)

**Sign in page:**

![sign_in_page](https://cloud.githubusercontent.com/assets/15610747/25229232/caef76e6-25cf-11e7-8b2b-5fdb70fe90cb.png)

The assumption is:
 1. users are employees in the shop;
 2. users can be `admin` or _standard_;
 3. users do not have email address;
 4. only `admin` user can create new users;

Users can sign in and out, through `name` and `password`.  
Every user can create new products, orders and customers.  
Every user can edit and update products, orders and customers created by other users.  
Only `admin` users can import products into the db through a CSV file.

**Admin page:**

![admin_page](https://cloud.githubusercontent.com/assets/15610747/25229561/0ed9a8e4-25d1-11e7-9aac-ead5c2dc1d97.png)

Only `admin` users can access this page.  
Links to _demo users_ and _admin_`edit`, are hidden in order to mantain these users available on [heroku demo app]().
However, it is still possible to access `users#edit` and modify users data. This will be fixed as soon as possible through `authorization` controller.

### Welcome

**Landing page after sign in:**

![welcome_index_small](https://cloud.githubusercontent.com/assets/15610747/25228626/642d3792-25cd-11e7-8bab-2d7600b13ba0.png)

On this page the user can find many informations and links to products, orders and customers.  
On the products table, products status is displayed through a meaningful coloured background:
- light green -> `in_stock`
- light yellow -> `arriving` on time
- light red -> `arriving` late
On the right you can find the **Arrived** button. Clicking on that button will change the `status` of the product and start the email notification process to customers waiting for it.

On the orders table, users can find orders' progressive numbers, orders' customer name and on the right the **Close** button, which users have to click on when customer come and collect their products.

### Products

**New product page:**

![products_new](https://cloud.githubusercontent.com/assets/15610747/25228317/419e235e-25cc-11e7-991f-4321dbae31aa.png)

Products are described by:
- `initiative`, the fact that they can be included in a promo; usually, indicated by _promo number/current year_;
- if left blank, `initiative` will default to _no promo_ value;
- `local_code`, an numeric code that refers to the product (**required**);
- `description` (**required**);
- `barcode` (**required**);
- `default_promo`, product price without promotion (**required if `promo_price` is blank**);
- `promo_price`, product price when included in promotion (**required if `default_price` is blank**);
- `quantity`, available or arriving (**required**);
- `status`, can be _in stock_ or _arriving_ (**required**);
- `arriving_date`, is required if `product.status` is set to _arriving_.


**Product index page:**

![products_index_small](https://cloud.githubusercontent.com/assets/15610747/25228338/587378c2-25cc-11e7-99d4-be9fd68c9da4.png)

This page shows many products and their important data.  
Products status is displayed through a coloured Bootstrap label, while the right you can find the **Arrived** button. Clicking on that button will change the `status` of the product and start the email notification process to customers waiting for it.

### Customers

**Customers index page:**

![customers_index](https://cloud.githubusercontent.com/assets/15610747/25229971/bfa8dc2a-25d2-11e7-89a9-f74322b6c28c.png)

This page takes a list of customers and their info.  
On the right you have links to `show` and `edit` pages and a button to create a new order for customers.

**Customers show page:**

![customers_show](https://cloud.githubusercontent.com/assets/15610747/25230260/a04474e2-25d3-11e7-9918-1a68e89a5fe7.png)

The `customers/show` page brings all informations about the customer and a _Orders history_ table were the users can retrieve customer's orders and their `status`, displayed through a coloured label.


### Orders

**Orders index page:**

![orders_index](https://cloud.githubusercontent.com/assets/15610747/25230515/8d0e2aa2-25d4-11e7-9324-f9f12f3b530e.png)

The table here is very similar to the one on the landing page after sign in.  
It stores all data from orders; `status` is displayed through a coloured label, while on the right there's a button to close the order when customers come and collect their products.

**Orders show page:**

![orders_show](https://cloud.githubusercontent.com/assets/15610747/25230891/0345e5f6-25d6-11e7-9a58-0ec5212570f2.png)

This page brings informations on order's customer (name, email, phone), on the shop and on order's products (barcode, description, quantity, item price and total price).  
This is a crucial page for the application. Here users can add and remove products from customers' orders.  
Products can be added to order from a dropdwon menu, while they can be removed clicking on the **Remove** button on the right.  
The dropdown menu lists the available products and their remaining quantity.  
Once the product quantity reaches zero, it disappears from the dropdown list.  
Users can [print this page, cleared of useless info with `@media print` css styling,](https://cloud.githubusercontent.com/assets/15610747/25231261/876dc7f8-25d7-11e7-916b-7d60c519ceb1.png) as a receipt for the customer.
