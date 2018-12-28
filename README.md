# Interview Homework Assignment

## Assignment
Refactor ProductivityController.Show method and submit by Dec 28

## Summary of Submission
Created new Rails 4.2.11 application with just the parts needed to make the ProductivityController functional.

Original code is on the master branch. Refactored code is on the productivity_controller_refactor branch and with a pull request awaiting approval.

## Refactoring Steps
* Created System Tests for original code
* Created Queries folder to hold classes needed to handle complexity of data acquisition
* Created Query Tests
* Created Presenter Tests
* Created View Tests
* Note: Did not create tests for all the models

## Project Setup

### Atom
* Spent 6-8 hours learning and setting up Atom including
  * Main Packages
    * Linter -> Ruby, SCSS, Rubocop
    * Highlighting -> rspec
    * Rubocop
    * Minimap for a sublime like tiny preview
    * PlatformIO IDE Terminal
  * Updated Navigation for improved Split creation, removal, and traversal

### Rails
* Rails: v4.2.11
* Ruby: 2.4.5
* Javascript
  * Abstraction: CoffeeScript
    * Charting Library: Highcharts
* HTML Template: Slim
* CSS: Bootstrap, SCSS
* Database: MySQL
* Testing: rspec, selenium, capybara, factory_girl

### Project
* Created new Rails 4.2.11 Project
* Copied Files from Original Project
  * productivity_controller.rb
  * models and migrations needed to support database schema for the controller
  * Assets needed to support controller
* Created simplified seed.rb to have some data to view when running the rails server
* Simplified the routing structure to remove the concept of a parent Report Controller
*
