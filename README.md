---
languages: ruby
tags: activerecord, playlister, orm
---

# Playlister on ActiveRecord

## Description

In this lab, we'll be recreating the basic functionality of Playlister using ActiveRecord associations. We'll have three models: Artists, Songs, and Genres. By writing a few migrations and making use of the appropriate ActiveRecord macros, we want to end up with three models that are associated with one another in a way that makes sense. I should be able to: ask an Artist about its songs and genres, ask a Song about its genre and its artist, and ask a Genre about its songs and artists.

## Instructions

There are a number of ways to approach solving this lab; the following steps are only a suggestion. Feel free to approach it in any order you feel is appropriate.

### Some Notes

1. Every time you type `rspec` into your command line, a Rake task will be triggered that will migrate your database. If you'd like to see how this task works, look in the `Rakefile` under the `:migrate` task. It's actually a bit weird to read through, as there's a bit of metaprogramming magic going on.

  Basically, we're first dropping every table in the database, then iterating through the `db/migrations` folder, using the name of every file to form the correct class name for each migration. Then, using `Kernel.const_get()`, we're converting that name into an actual constant that we can call the `.migrate` method on. Don't worry if you don't get all that's going on. For our purposes, we can just take for granted that it's happening for us.

2. The connection to the database has been taken care of for you. Whenever we migrate (or interact with in any way, really) the database, we set an environment variable, called `PLAYLISTER_ENV`. Based on this environment variable, we connect to a test, development, or production database. This is all being taken care of by the code in two files in `lib/support`. Again, no need to fully understand what's going on there. One of the files, `db_registry` makes use of an OpenStruct. If you'd like to learn more, check out the [documentation](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/ostruct/rdoc/OpenStruct.html). You can sort of think of an OpenStruct as a really fancy hash.

### Steps

1. The first thing you should do is run `rspec` from your command line. You'll probably be able to knock out a few errors pretty quickly here.

2. It may be useful to go ahead and define your models at this point. You'll need to do this in the `app/models` directory. Two of the files have already been created for you, but you'll need to make one for your `Song` model. Remember, since we're using ActiveRecord, models should inherit from `ActiveRecord::Base`. A sample definition would look like this:

  ```ruby
  class SomeClass < ActiveRecord::Base
  end
  ```

3. You'll probably get some errors now that are related to the database. This would probably be a good time to write your migrations. Four of the files for these migrations have been created for you in `db/migrations`, but you'll need to add a fifth to make all of the specs pass. Notice that there is a very strong naming convention at play here. In the file `01_create_songs.rb`, there is a migration defined called `CreateSongs`.

4. Once you've set up your migrations, it's time to create the associations between your models. Using the ActiveRecord macros you have available to you, set up the relationships so that the tests pass. Here's a hint: you'll need to set up a couple of `:through` associations.