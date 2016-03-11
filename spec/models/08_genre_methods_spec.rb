describe 'Genre Methods' do
  before do
    @genre = Genre.create(name: "Hip Hop")
    @genre.artists << Artist.create(name: "MJ")
    @genre.artists << Artist.create(name: "Adele")
    @genre.artists << Artist.create(name: "James Brown")
    @genre.save
  end


  it '#song_count' do
    @genre.songs << Song.create(name: "Something By That Person Who Sings Stuff")
    @genre.save

    expect(@genre.song_count).to eq(4)
  end

  it '#artist_count' do
    expect(@genre.artist_count).to eq(3)
  end

  describe '#all_artist_names' do 
    it 'returns an array of strings containing every musicians name' do
      expect(@genre.all_artist_names).to eq(["MJ", "Adele", "James Brown"])
    end
  end
end