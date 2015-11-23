describe 'Genre' do
  before do
    @genre = Genre.create(name: "Hip Hop")
  end

  after do 
    clean_database
  end

  it 'has a name' do
    expect(Genre.where(name: "Hip Hop").first).to eq(@genre)
  end
  
end