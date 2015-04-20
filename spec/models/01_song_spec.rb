describe 'Song' do
  before do
    @song = Song.create(name: "Forever")
  end

  after do 
    clean_database
  end

  it 'has a name' do
    expect(Song.where(name: "Forever").first).to eq(@song)
  end

end