# Interview Homework Assignment

## Assignment
Refactor ProductivityController.Show method and submit by Dec 28

## Summary of Submission
Created new Rails 4.2.11 application with just the parts needed to make the ProductivityController functional.

Original code before refactor is on the master branch. Refactored code is on the productivity_controller_refactor branch with a pull request awaiting approval.

## Use Case for the Productivity View
* User can see the weekly, monthly, or quarterly average team effort as a percentage applied to project work vs everything else. Note: 100% Productivity would mean that all the team members in a category worked all their hours on a project and not vacation or support tickets.
* User can quickly see the productivity of different job functions and locations through simple filters on the data via the UI.
* User can control on the fly if the averages are calculated per week, month, or quarter

## Terminology
* **Time Group** is a date range corresponding to a week, month, or quarter.
* **Effort** is the amount of time worked on a task (bucket)
* **Effort Bucket** Type of work done
* **Effort Bucket Group** Combination of one or more buckets to group similar buckets
* **Effort Week** The week work was done
* **Effort Entry** Relates amount of effort to team member, effort bucket, and effort week
* **Project** Generic project that maps to a Jira Project or Pivotal Tracker project

## Refactoring Steps
* Created Factories and a hello world type Feature Test for original code
* Created app/services folder to hold classes needed to handle complexity of data acquisition
* Refactored ProductivityController into ProductivityQueryService, ProductivityDataService, ProductivityGroupDataService
  * **ProductivityQueryService** responsible for iterating over the weeks with data and querying the team_member effort
  * **ProductivityDataService** stores a hash table with the time_grouping as the key with all the productivity data. It has convenience methods for extracting data in different structures.
  * **ProductivityGroupDataService** stores a single time grouping of productivity data
* Added one system proof of concept test and one unit proof of concept test

## Project Setup

### Atom
* Spent 6-8 hours learning and setting up Atom including
  * Main Packages
    * Linter -> Ruby, SCSS, Rubocop
    * Highlighting -> RSpec
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
* Testing: RSpec, Selenium, Capybara, Factory Girl

### Project
* Created new Rails 4.2.11 Project
* Copied Files from Original Project
  * productivity_controller.rb
  * models and migrations needed to support database schema for the controller
  * Assets needed to support controller
* Created simplified seed.rb to have some data to view when running the rails server
* Simplified the routing structure to remove the concept of a parent Report Controller
* Setup RSpec with features using factory girl to generate database data
* Refactored

### Todo
* Complete system and unit testing
