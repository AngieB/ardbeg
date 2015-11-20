class Ardbeg.Views.PostsIndex extends Backbone.View

  template: JST['posts/index']

  events:
    'click [data-posts-index]': 'render'
    'click [data-post-show]': 'showPostView'
    'click [data-posts-new]': 'newPostView'
    'click [data-post-edit]': 'editPostView'
    'click [data-posts-destroy]': 'destroyPost'

  render:  ->
    @collection.fetch(success: @onSuccess, error: @onError)
    @

  onSuccess: =>
    $('[data-flash-message]').parent('div').removeClass('alert-danger')
    $('[data-flash-message]').empty()
    $(@el).html(@template(collection: @collection))

  onError: =>
    $('[data-flash-message]').parent('div').addClass('alert-danger')
    $('[data-flash-message]').empty().append(errors.responseText)

  showPostView: (event) ->
    event.preventDefault()
    postId = $(event.currentTarget).parents('li').data('post-id')
    post = @collection.find(id: postId)
    view = new Ardbeg.Views.PostsShow(model: post, collection: @collection)
    $('[data-board-message]').empty().html(view.render().el)

  newPostView: (event) ->
    event.preventDefault()
    view = new Ardbeg.Views.PostsNew(collection: @collection)
    $('[data-board-message]').empty().html(view.render().el)

  editPostView: (event) ->
    event.preventDefault()
    postId = $(event.currentTarget).parents('li').data('post-id') || $(event.currentTarget).data('post-id')
    post = @collection.find(id: postId)
    view = new Ardbeg.Views.PostsEdit(model: post, collection: @collection)
    $('[data-board-message]').empty().html(view.render().el)

  destroyPost: (event) ->
    event.preventDefault()
    $postEl = $(event.currentTarget).parents('li')
    postId = $postEl.data('post-id')
    post = new Ardbeg.Models.Post(id: postId)

    post.destroy
      wait: true
      success: @updatePostIndex
      error: @onError

  updatePostIndex: (model, response) =>
    $('[data-flash-message]').parent('div').removeClass('alert-danger')
    $('[data-flash-message]').empty()
    @collection.remove(model)
    $("[data-post-id='#{model.id}'").remove()
