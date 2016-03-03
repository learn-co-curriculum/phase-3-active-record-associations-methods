describe 'Artist Methods' do
  before do
    @prince = Artist.create(name: "Prince")
    song = Song.create(name: "Super Hip Music")
    genre = Genre.create(name: "Soul")
    song.genre = genre
    song.save
    @prince.songs << song
  end


  describe '#get_genre_of_first_song' do
    it 'returns the genre of the artists first saved song' do
      expect(@prince.get_genre_of_first_song).to be_a(Genre)
      expect(@prince.get_genre_of_first_song.name).to eq("Soul")
    end
  end

  describe '#song_count' do
    it '#song_count' do
      @prince.songs.create(name: "FUNKNROLL")
      @prince.songs.create(name: "Little Red")
      @prince.songs.create(name: "Batdance")

      expect(@prince.song_count).to eq(4)
    end
  end

  describe '#genre_count' do
    it 'returns the number of genres associated with the artist' do
      expect(@prince.genre_count).to eq(1)
    end
  end
end