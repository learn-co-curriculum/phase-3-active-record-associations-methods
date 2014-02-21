require_relative '../spec_helper'

describe 'Song' do
  before do
    @song = Song.create(name: "Forever")
  end

  it 'has a name' do
    expect(Song.where(name: "Forever").first).to eq(@song)
  end

  it 'has a genre' do
    genre = Genre.create(name: "Rock")
    @song.genre = genre
    @song.save

    expect(Song.find_by(name: "Forever").genre).to eq(genre)
  end

  it 'can have an artist' do
    artist = Artist.create(name: "Prince")
    @song.artist = artist
    @song.save

    expect(Song.where(name: "Forever").first.artist).to eq(artist)
  end

  it 'can be created with an artist as an attribute' do
    artist = Artist.create(name: "The Beatles")
    song = Song.create(name: "Yellow Submarine", artist: artist)

    expect(Song.where(name: "Yellow Submarine").first.artist).to eq(artist)
  end

  it 'can build genres' do
    genre = @song.genres.build(name: "Rap")
    genre.save

    expect(Song.where(name: "Forever").first.genre).to eq(genre)
    expect(Genre.where(name: "Rap").first.songs).to include(@song)
  end
end