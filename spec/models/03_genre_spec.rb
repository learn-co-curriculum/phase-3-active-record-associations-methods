describe Genre do

  it 'has a name' do
    genre = Genre.create(name: "Hip Hop")
    expect(Genre.find_by(name: "Hip Hop")).to eq(genre)
  end

end
