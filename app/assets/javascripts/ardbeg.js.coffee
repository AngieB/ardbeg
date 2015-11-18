window.Ardbeg =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Ardbeg.Routers.Posts()
    Backbone.history.start()

$(document).ready ->
  Ardbeg.initialize()
