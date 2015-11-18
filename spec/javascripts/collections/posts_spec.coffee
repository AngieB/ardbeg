describe 'Ardbeg.Collections.Posts', ->
  it 'should be defined', ->
    expect(Ardbeg.Collections.Posts).toBeDefined();

  it 'can be instantiated', ->
    posts = new Ardbeg.Collections.Posts()
    expect(posts).not.toBeNull()
