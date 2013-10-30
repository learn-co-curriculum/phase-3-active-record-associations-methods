require_relative '../spec_helper'

describe Song do
  it 'has a name' do
    song = Song.new(:name => "Forever")
    song.save

    expect(Song.where(:name => "Forever").first).to eq(song)
  end

  it 'has an artist' do
    song = Song.new(:name => "Forever")
    artist =  Artist.new(:name => "Haim")
    song.artist = artist 
    song.save

    expect(Song.where(:name => "Forever").first.artist).to eq(artist)
  end
end