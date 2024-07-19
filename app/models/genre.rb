class Genre < ActiveRecord::Base
  has_many :songs
  has_many :artists, through: :songs

  def song_count
    self.songs.length
  end

  def artist_count
    self.artists.length
  end

  def all_artist_names
    self.artists.map do |a|
      a.name
    end
  end
end
