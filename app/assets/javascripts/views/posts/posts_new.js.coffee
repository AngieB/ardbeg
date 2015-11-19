class Ardbeg.Views.PostsNew extends Backbone.View

  template: JST['posts/form']

  events:
    'click [data-post-submit]': 'createPost'
    'keyup input, textarea': 'requiredInput'

  render: ->
    newPost = new Ardbeg.Models.Post()
    $(@el).html(@template(model: newPost))
    this

  createPost: (event) ->
    event.preventDefault()
    attributes =
      title: $('#post-title').val()
      name: $('#post-name').val()
      body: $('#post-body').val()
    @collection.create attributes,
      wait: true
      success: @onSuccess
      error: @onError

  onSuccess: =>
    $('[data-flash-message]').parent('div').removeClass('alert-danger')
    $('[data-flash-message]').empty()
    view = new Ardbeg.Views.PostsIndex(collection: @collection)
    $('[data-posts]').html(view.render().el)

  onError: (model, errors) =>
    $('[data-flash-message]').parent('div').addClass('alert-danger')
    $('[data-flash-message]').empty().append(errors.responseText)

  requiredInput: (event) ->
    $input = $(event.currentTarget)
    if $input.val().length > 0
      $input.parent('fieldset').removeClass('has-error')
      $input.parent('fieldset').addClass('has-success')
    else
      $input.parent('fieldset').removeClass('has-success')
      $input.parent('fieldset').addClass('has-error')
