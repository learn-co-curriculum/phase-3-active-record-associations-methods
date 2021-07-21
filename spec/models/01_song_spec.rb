describe Song do
  
  it 'has a name' do
    song = Song.create(name: "Forever")
    expect(Song.find_by(name: "Forever")).to eq(song)
  end

end
