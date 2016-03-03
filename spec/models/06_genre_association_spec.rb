describe 'Genre Associations' do
  before do
    @genre = Genre.create(name: "Hip Hop")
  end

  it 'has many songs' do
    @genre.songs << Song.create(name: "Something By That Person Who Sings Stuff")
    @genre.save

    found_song = Song.find_by(name: "Something By That Person Who Sings Stuff")
    expect(found_song.genre).to eq(@genre)
  end

  it 'is also associated with an artist' do
    artist = Artist.create(name: "Fun Person Who Sings")
    song = Song.create(name: "Sweet Tunez", genre: @genre)
    artist.songs << song
    artist.save
    @genre.artist_count
    expect(@genre.artists).to include(artist)
  end
  
end