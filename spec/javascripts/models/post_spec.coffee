describe 'Ardbeg.Models.Post', ->
  it 'should be defined', ->
    expect(Ardbeg.Models.Post).toBeDefined()

  it 'can be instantiated', ->
    post = new Ardbeg.Models.Post();
    expect(post).not.toBeNull();
