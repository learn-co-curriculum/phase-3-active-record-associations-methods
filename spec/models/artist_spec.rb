require_relative '../spec_helper'

describe Artist do
  it 'has a name' do
    prince = Artist.new(:name => "Prince")
    prince.save

    expect(Artist.find_by_name("Prince")).to eq(prince)
  end

  it 'can push many songs' do
    prince = Artist.new(:name => "Prince")
    prince.save

    s = Song.new(:name => "A Song By Prince")    
    s2 = Song.new(:name => "A Song By Prince 2")    
    prince.songs << [s,s2]

    expect(Artist.find_by_name("Prince").songs.count).to eq(2)
  end

  it 'can push many songs' do
    prince = Artist.new(:name => "Prince")

    prince.songs.build(:name => "Song 1")
    prince.songs.build(:name => "Song 2")

    prince.save

    expect(Artist.find_by_name("Prince").songs.count).to eq(2)
  end




end