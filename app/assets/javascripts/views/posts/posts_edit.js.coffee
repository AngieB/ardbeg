class Ardbeg.Views.PostsEdit extends Backbone.View

  template: JST['posts/form']

  events:
    'click [data-post-submit]': 'updatePost'
    'keyup input, textarea': 'requiredInput'

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

  onSuccess: (model, response) =>
    $('[data-flash-message]').parent('div').removeClass('alert-danger')
    $('[data-flash-message]').empty()
    @collection.add(model)
    view = new Ardbeg.Views.PostsIndex(collection: @collection)
    $('[data-posts]').html(view.render().el)

  handleError: (model, errors)  =>
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
