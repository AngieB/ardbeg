class Ardbeg.Views.PostsShow extends Backbone.View

  template: JST['posts/show']

  events:
    'click [data-post-edit]': 'editPost'

  render: ->
    $(@el).html(@template(model: @model))
    this

  updatePost: (event) ->
    event.preventDefault()
    attributes =
      title: $('#post-title').val()
      name: $('#post-name').val()
      body: $('#post-body').val()
    @model.save attributes,
      patch: true
      wait: true
      success: @onSuccess
      error: @handleError

  onSuccess: =>
    view = new Ardbeg.Views.PostsIndex(collection: @collection)
    $('[data-posts]').html(view.render().el)

  handleError:  =>
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages
