describe Artist do
  
  it 'has a name' do
    prince = Artist.create(name: "Prince")
    expect(Artist.find_by(name: "Prince")).to eq(prince)
  end

end
