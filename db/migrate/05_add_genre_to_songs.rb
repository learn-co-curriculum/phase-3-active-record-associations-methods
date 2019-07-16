class AddGenreToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :genre_id, :integer
  end
end