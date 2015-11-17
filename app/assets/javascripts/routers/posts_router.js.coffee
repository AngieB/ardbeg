class Ardbeg.Routers.Posts extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    view = new Ardbeg.Views.PostsIndex()
    $('[data-posts]').html(view.render().el)
