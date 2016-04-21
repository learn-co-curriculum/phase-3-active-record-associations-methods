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
    expect(@song.drake_made_this).to be_a(Artist)
    expect(@song.drake_made_this.name).to eq("Drake")
  end
end
