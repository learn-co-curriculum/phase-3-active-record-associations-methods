class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
    end
  end
end
