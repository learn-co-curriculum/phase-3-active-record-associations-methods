---
tags: activerecord, playlister, orm, associations
languages: ruby
resources: 2
---

# Playlister on ActiveRecord

## Description

In this lab, we'll be recreating the basic functionality that we already built out in [Playlister-rb](http://learn.flatironschool.com/lessons/940) but this time, using ActiveRecord associations. 

We'll have three models: Artists, Songs, and Genres. By writing a few migrations and making use of the appropriate ActiveRecord macros, we want to end up with three models that are associated with one another in a way that makes sense. I should be able to: ask an Artist about its songs and genres, ask a Song about its genre and its artist, and ask a Genre about its songs and artists.

## How ActiveRecord works

As an ORM, ActiveRecord works just like the ORM you've built already in labs like School Domain with DB. It provides its own abstractions and a similar API for interacting with the Database through your object model.

We're going to be using ActiveRecord to do two things: to store the data in a database (through a schema which we generate with migrations) to create associations between our objects (through ActiveRecord abstractions).

### Steps

1. The first thing you should do is run `rspec` from your command line. You'll probably be able to knock out a few errors pretty quickly here.

2. It may be useful to go ahead and define your models at this point. You'll need to do this in the `app/models` directory. Two of the files have already been created for you, but you'll need to make one for your `Song` model. Remember, since we're using ActiveRecord, models should inherit from `ActiveRecord::Base`. A sample definition would look like this:

  ```ruby
  class SomeClass < ActiveRecord::Base
  end
  ```

3. You'll probably get some errors now that are related to the database. This would probably be a good time to write your migrations. Four of the files for these migrations have been created for you in `db/migrations`, but you'll need to add a fifth to make all of the specs pass. Notice that there is a very strong naming convention at play here. In the file `01_create_songs.rb`, there is a migration defined called `CreateSongs`. The filename of the migration, excluding the version number in the first position, `create_songs` must match up to the migration class defined within the file, `CreateSongs`, without this convention, ActiveRecord will throw an error. `seperate_words_with_underscores_and_join_them_together_in_a_class_with_capitals` becomes `SeperateWordsWithUnderscoresAndJoinThemTogetherInAClassWithCapitals`.

4. Once you've set up your migrations, it's time to create the associations between your models.

### Associations

There are a bunch of ActiveRecord association macros available. Let's work through our domain here to figure out the best ones to use.

I like to think of Song as a connector between Artist and Genre (Taylor Swift isn't in the genre pop unless she writes pop songs, right?). So therefore:

* An Artist has many Songs, and it has many Genres, through Songs.
* A Genre has many Songs, and it has many Artists, through Songs.
* Because of the relationship between Artist/Song and Genre/Song, a Song belongs to an Artist and belongs to a Genre

ActiveRecord has some great macros to achieve the above associations:

* [`has_many`](http://guides.rubyonrails.org/association_basics.html#the-has-many-association)
* [`has_many though`](http://guides.rubyonrails.org/association_basics.html#the-has-many-through-association)
* [`belongs_to`](http://guides.rubyonrails.org/association_basics.html#the-belongs-to-association)

What does this look like in our schema, in our table definitions and structure?

If a Song belongs to an Artist, as well as a Genre, then that means that there are foreign keys on the Songs table that point to the id on the respective tables.

Song would look something like this:

|id |name        |artist_id |genre_id |
|---|------------|----------|---------|
|2  |Shake It Off|1         |1        |

And Artist:

|id |name         |
|---|-------------|
|1  |Taylor Swift |

And Genre:

|id |name |
|---|-----|
|1  |pop  |

The `artist_id` of 1 points to the row in the Artist table where the id is 1. And the `genre_id` of 1 points to the row in the Genre table where the id is 1.

These foreign keys, in conjunction with the ActiveRecord association macros (`belongs_to`, `has_many`, `has_many through`) will allow us query to get an artist's songs or genres, a song's artist or genre, and a genre's songs and artists entirely through ActiveRecord provided methods on our classes.

### Some Notes

1. Every time you type `rspec` into your command line, a Rake task will be triggered that will migrate your database. If you'd like to see how this task works, look in the `Rakefile` under the `:migrate` task. It's actually a bit weird to read through, as there's a bit of metaprogramming magic going on.

  Basically, we're first dropping every table in the database, then iterating through the `db/migrations` folder, using the name of every file to form the correct class name for each migration. Then, using `Kernel.const_get()`, we're converting that name into an actual constant that we can call the `.migrate` method on. Don't worry if you don't get all that's going on. For our purposes, we can just take for granted that it's happening for us.

2. The connection to the database has been taken care of for you. Whenever we migrate (or interact with in any way, really) the database, we set an environment variable, called `PLAYLISTER_ENV`. Based on this environment variable, we connect to a test, development, or production database. This is all being taken care of by the code in two files in `lib/support`. Again, no need to fully understand what's going on there. One of the files, `db_registry` makes use of an OpenStruct. If you'd like to learn more, check out the [documentation](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/ostruct/rdoc/OpenStruct.html). You can sort of think of an OpenStruct as a really fancy hash.

### Write More Tests

1. Once you've managed to make the test suite pass, write your own tests. Within these tests, you should exercise working with different ways of creating associations.

### Bonus

1. Write a `db:seed` rake task.
2. Integrate your SiteGenerator within this version of Playlister.

## Resources
* [Ruby Docs](http://www.ruby-doc.org/) - [OpenStruct](http://www.ruby-doc.org/stdlib-2.1.0/libdoc/ostruct/rdoc/OpenStruct.html)
* [Rails Guides](http://guides.rubyonrails.org/) - [Active Record Basics](http://guides.rubyonrails.org/association_basics.html)
