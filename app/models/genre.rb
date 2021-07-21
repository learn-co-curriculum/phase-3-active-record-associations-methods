class Genre < ActiveRecord::Base
  has_many :songs
  has_many :artists, through: :songs

  def song_count
    self.songs.count
  end

  def artist_count
    self.artists.count
  end

  def all_artist_names
    self.artists.map do |artist|
      artist.name
    end

    # Or, use #pluck
    # self.artists.pluck(:name)
  end
end
