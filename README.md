# Volunteer Tracker

This web app is desiged to help a nonprofit organization to track its volunteers. The user will have the option to add, delete, update, and view both the projects that the organization has going and also the volunteers who are assigned to those projects.

### Prerequisites

Web browser with ES6 compatibility
Examples: Chrome, Safari

Ruby 2.4.1
Bundler

### Installing

Installation is quick and easy! You can clone this repository to your machine, navigate to the file path in your terminal, and run 'app.rb' by typing $'ruby app.rb'. You will need to follow the steps in 'Setting Up Your Environment' to create the necessary database structure. After you run 'app.rb' you will need to copy the localhost path into your web browser. The standard localhost for Sinatra is port 4567

#### Setting Up Your Environment (SQL)

Connect to postgres and create a database by running the following commands:

* create database volunteer_tracker;
* create table volunteers (volunteer_id uuid primary key, name varchar, project_id uuid);
* create table projects (project_id uuid primary key, name varchar);
* create table hours (id uuid primary key, project_id uuid, volunteer_id uuid, date_worked date, hours int);
* create database volunetter_tracker_test with template volunteer_tracker;

## Built With

* Ruby
* Sinatra
* Postgres
* HTML
* CSS
* Bootstrap https://getbootstrap.com/
* ES6
* Jquery https://jquery.com/
 
## Authors

* Spencer Ruiz

## License

Copyright © 2017 Spencer Alan Ruiz
