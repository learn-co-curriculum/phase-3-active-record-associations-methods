describe 'Song Associations' do
  let(:song) { Song.create(name: "Forever") }

  it 'has a genre' do
    genre = Genre.create(name: "Rock")
    song.genre = genre
    song.save

    expect(Song.find_by(name: "Forever").genre).to eq(genre)
  end

  it 'can have an artist' do
    artist = Artist.create(name: "Prince")
    song.artist = artist
    song.save

    expect(Song.find_by(name: "Forever").artist).to eq(artist)
  end

  it 'can be created with an artist as an attribute' do
    artist = Artist.create(name: "The Beatles")
    Song.create(name: "Yellow Submarine", artist: artist)

    expect(Song.find_by(name: "Yellow Submarine").artist).to eq(artist)
  end

  it 'can build genres' do
    genre = song.build_genre(name: "Rap")
    song.save

    expect(Song.find_by(name: "Forever").genre).to eq(genre)
    expect(Genre.find_by(name: "Rap").songs).to include(song)
  end

end
