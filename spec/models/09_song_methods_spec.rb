describe 'Song Methods' do
  before do
    @song = Song.create(name: "Forever")
  end


  it '#get_genre_name' do
    genre = Genre.create(name: "Rock")
    @song.genre = genre
    @song.save

    expect(@song.get_genre_name).to eq("Rock")
  end

  it '#drake_made_this' do
    expect(@song.artist).to eq(nil)

    @song.drake_made_this

    expect(@song.artist).to be_a(Artist)
    expect(@song.artist.name).to eq("Drake")

    expect(Artist.all.length).to eq(1)

    kiki = Song.create(name: 'In My Feelings')

    kiki.drake_made_this
    
    expect(kiki.artist).to be_a(Artist)
    expect(kiki.artist.name).to eq("Drake")

    expect(Artist.all.length).to eq(1), 'Create only one Drake artist record in the database, even if method is run multiple times'
    
  end
end
