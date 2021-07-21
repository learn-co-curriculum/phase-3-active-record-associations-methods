describe 'Song Methods' do
  before do
    Song.create(name: "Forever")
  end

  describe '#get_genre_name' do
    it "returns a string for the name of the song's genre" do
      song = Song.find_by(name: "Forever")
      genre = Genre.create(name: "Rock")
      song.genre = genre
      song.save
  
      expect(song.get_genre_name).to eq("Rock")
    end
  end

  describe '#drake_made_this' do
    it "changes the artist who made the song to Drake" do
      song = Song.find_by(name: "Forever")
      song.drake_made_this
      
      expect(song.artist).to have_attributes(class: Artist, name: "Drake")
    end

    it "creates only one Drake artist in the database, even if run multiple times" do
      song = Song.find_by(name: "Forever")
      song2 = Song.create(name: "Forever 2")

      song.drake_made_this
      song2.drake_made_this

      expect(Artist.all.length).to eq(1)
    end
    
  end
end
