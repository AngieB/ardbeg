class Ardbeg.Models.Post extends Backbone.Model
  urlRoot: '/api/posts'

  buildDateTime:  ->
    dateTime = @get('updated_at') || @get('created_at')
    "#{moment(dateTime).format('LL')} @ #{moment(dateTime).format('hh:mm A')}"
