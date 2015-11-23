class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def get_genre_of_first_song
    #return the genre of the artist's first saved song
  end

  def song_count
    #return the number of songs associated with the artist
  end

  def genre_count
    #return the number of genres associated with the artist
  end
end
