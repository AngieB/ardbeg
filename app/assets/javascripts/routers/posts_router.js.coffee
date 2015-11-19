class Ardbeg.Routers.Posts extends Backbone.Router
  routes:
    '':           'index'

  initialize: ->
    @collection = new Ardbeg.Collections.Posts()

  index: ->
    view = new Ardbeg.Views.PostsIndex(collection: @collection)
    $('[data-posts]').html(view.render().el)
