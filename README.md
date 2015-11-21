# Active Record Association Methods

## Objectives

1. Understand the common methods we have access to from our ActiveRecord associations 
2. Use the methods that ActiveRecord gives you based on your associations

Previously, we learned what Active Record associations are and how to use them. In this lab, we are going to start with the association relationships already coded for `Songs`, `Genres`, and `Artists`. These associations look like this:

* Artists have many songs and a song belongs to an artist. 
* Artists have many genres through songs. 
* Songs belong to a genre. 
* A genre has many songs. 
* A genre has many artists through songs. 

You may recall that by writing a few migrations and making use of the appropriate ActiveRecord macros, we will be able to:

* ask an Artist about its songs and genres
* ask a Song about its genre and its artist
* ask a Genre about its songs and artists.



We will build these associations through the use of Active Record migrations and macros. 

## Building our Migrations

### The Song model

A song will belong to an artist *and* belong to a genre. Before we worry about the migration that will implement this in our songs table, let's think about what that table will look like:


|id |name        |artist_id |genre_id |
|---|------------|----------|---------|
|2  |Shake It Off|1         |1        |

We can see that the songs table will have an `artist_id` column and a `genre_id` column. We will give a given song an `artist_id` value of the artist it belongs to. The same goes for genre. These foreign keys, in conjunction with the ActiveRecord association macros will allow us query to get an artist's songs or genres, a song's artist or genre, and a genre's songs and artists entirely through ActiveRecord provided methods on our classes.

Let's write the migration that will make this happen. 

* Create a file, `db/migrations/001_create_song_table.rb`
* Write the following migration:

```ruby
class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name 
      t.integer :artist_id
      t.integer :genre_id
    end
  end
end
```

### The Artist Model

An artist will have many songs and it will have many genres *through* songs. These associations will be taken care of entirely through AR macros, which we'll get to in a bit. 

Let's take a look at what our artists table will need to look like:


|id |name         |
|---|-------------|
|1  |Taylor Swift |

Our artists table just needs a `name` column. Let's write the migration. In `db/migrate/002_create_artists_table.rb`:

```ruby
class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
    end
  end
end
```

### The Genre Model

A genre will have many songs and it will have many artists through songs. These associations will be taken care of entirely through AR macros, which we'll get to in a bit. 

Let's take a look at what our genres table will need to look like:

|id |name |
|---|-----|
|1  |pop  |

Let's write our migration. In `db/migrate/003_create_genres_table.rb`:

```ruby
class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :name 
    end
  end
end
```

Great! Now go ahead and run `rake db:migrate` in your terminal to execute our table creations. 

## Building our Associations using AR Macros

### What is a macro?

A macro is a method that writes code for us (think metaprogramming). By invoking a few methods that come with Active Record, we can implement all of the associations we've been discussing. 

We'll be using the following AR macros (or methods):

* [`has_many`](http://guides.rubyonrails.org/association_basics.html#the-has-many-association)
* [`has_many through`](http://guides.rubyonrails.org/association_basics.html#the-has-many-through-association)
* [`belongs_to`](http://guides.rubyonrails.org/association_basics.html#the-belongs-to-association)

Let's get started. 

### A Song Belongs to an Artist and A Genre

Create a file, `app/models/song.rb`. Define your `Song` class to inherit from `ActiveRecord::Base`. This is very important! If we don't inherit from Active Record Base, we won't get our fancy macro methods. 

```ruby
class Song < ActiveRecord::Base

end
```

We need to tell the `Song` class that it will produce objects that can belong to an artist. We will do it with the `belongs_to` macro:

```ruby
class Song < ActiveRecord::Base
  belongs_to :artist
end
```

Songs also belong to a genre, so we'll use the same macro to implement that relationship:

```ruby
class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
end
```

### An Artist Has Many Songs

Create a file, `app/models/artist.rb`. Define your `Artist` class to inherit from `ActiveRecord::Base`:

```ruby
class Artist < ActiveRecord::Base

end
```

We need to tell the `Artist` class that each artist object can have many songs. We will use the `has_many` macro to do it.

```ruby
class Artist < ActiveRecord::Base
  has_many :songs

end
```

And that's it! Now, because our songs table has an `artist_id` column and because our `Artist` class uses the `has_many` macro, an artist has many songs!

It is also true that an artist has many genres through songs. We will use the `has_many through` macro to implement this:

```ruby
class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs
end
```

### Genres Have Many Songs and Have Many Artists

Create a file `app/models/genre.rb`. In it, define a class, `Genre`, to inherit from `ActiveRecord::Base`. 

```ruby
class Genre < ActiveRecord::Base

end
```

A genre can have many songs. Let's implement that with the `has_many` macro:

```ruby
class Genre < ActiveRecord::Base
  has_many :songs
end
```

A genre also has many artists through its songs. Let's implement this relationship with the `has_many through` macro:

```ruby
class Genre < ActiveRecord::Base
  has_many :songs
  has_many :artists, through: :songs
end
```

And that's it!

## Our Code in Action: Working with Associations

Go ahead and run the test suite and you'll see that we are passing all of our tests! Amazing! Our associations are all working, just because of our migrations and use of macros. 

Let's play around with our code. 

In your console, run `rake console`. Now we are in a Pry console that accesses our models. 

Let's make a few new songs:

```bash
[1]pry(main)> hello = Song.create(name: "Hello")
=> #<Song:0x007fc75a8de3d8 id: nil, name: "Hello", artist_id: nil, genre_id: nil>
[2]pry(main)> hotline_bling = Song.create(name: "Hotline Bling")
=> #<Song:0x007fc75b9f3a38 id: nil, name: "Hotline Bling", artist_id: nil, genre_id: nil>
```

Okay, here we have two songs. Let's make some artists to associate them to. In the *same PRY sessions as above*:

```bash
[3] pry(main)> adele = Artist.create(name: "Adele")
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">
[4] pry(main)> drake = Artist.create(name: "Drake")
=> #<Artist:0x007fc75b163c60 id: nil, name: "Drake">
```

So, we know that an individual song has an `artist_id` attribute. We *could* associate `hello` to `adele` by setting `hello.artist_id=` equal to the `id` of the `adele` object. BUT! Active Record makes it so easy for us. The macros we implemented in our classes allow us to associate a song object directly to an artist object:

```bash
[5] pry(main)> hello.artist = adele
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">
```

Now, we can ask `hello` who its artist is:

```bash
[6] pry(main)> hello.artist
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">
```

We can even chain methods to ask `hello` for the *name* of its artist:

```bash
[7] pry(main)> hello.artist.name
=> "Adele"
```

Wow!

Go ahead and do the same for `hotline_bling` and `drake`. 

We can also ask our artists what songs they have. Let's make a second song for adele first:

```bash
[8] pry(main)> someone_like_you = Song.create(name: "Someone Like You")
=> #<Song:0x007fc75b5cabc8 id: nil, name: "Someone Like You", artist_id: nil, genre_id: nil>
[8] pry(main)> someone_like_you.artist = adele
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">
```

Now let's ask `adele` for her songs:

```bash
[9] pry(main)> adele.songs
=> []
```

Huh? How can `adele`'s collection of songs be empty? We associated two songs with `adele`! Here's the thing, and this is important to remember:

**The model that `has_many` is considered the parent. The model that `belongs_to` is considered the child. If you tell the child that it belongs to the parent, *the parent won't know about that relationship*. If you tell the parent that a certain child object has been added to its collection, *both the parent and the child will know about the association*.**

Let's see this in action. Let's create another new song and add it to `adele`'s songs collection:

```bash
[10] pry(main)> rolling_in_the_deep = Song.create(name: "Rolling in the Deep")
=> #<Song:0x007fc75bb4d1e0 id: nil, name: "Rolling in the Deep", artist_id: nil, genre_id: nil>
```

```bash
[11] pry(main)> adele.songs << rolling_in_the_deep
=> [ #<Song:0x007fc75bb4d1e0 id: nil, name: "Rolling in the Deep", artist_id: nil, genre_id: nil>]
[12] pry(main)> rolling_in_the_deep.artist
=> #<Artist:0x007fc75b8d9490 id: nil, name: "Adele">
```

We added `rolling_in_the_deep` to `adele`'s collection of songs and we can see the `adele` knows it has that song in the collection *and* `rolling_in_the_deep` knows about its artist. 

Notice that `adele.songs` returns an array of songs. When a model `has_many` of something, it will store those objects in an array. To add to that collection, we use the shovel operator, `<<`, to operate on that collection, treat `adele.songs` like any other array. 

Let's play around with some genres and our has many through association. 

```bash
[13] pry(main)> pop = Genre.create(name: "pop")
=> #<Genre:0x007fa34338d270 id: 1, name: "pop">
```

```bash
[14] pry(main)> pop.songs << rolling_in_the_deep
=> [#<Song:0x007fc75bb4d1e0 id: nil, name: "Rolling in the Deep", artist_id: nil, genre_id: nil>]
[15] pry(main)> pop.songs
=> [#<Song:0x007fc75bb4d1e0 id: nil, name: "Rolling in the Deep", artist_id: nil, genre_id: nil>]
[16] pry(main)> rolling_in_the_deep.genre
=> #<Genre:0x007fa34338d270 id: 1, name: "pop">
[17] pry(main)> pop.artists
=> [#<Artist:0x007fa342e34dc8 id: 1, name: "Adele">]
```

It's working!

