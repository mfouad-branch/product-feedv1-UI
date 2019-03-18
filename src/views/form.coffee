class ConvertFormView extends Backbone.View
  tagName: "form"
  events:
    "submit" : "onSubmit"

  initialize: ({@logsElem}) ->

  render: ->
    @$el.html """

    <form>
    <div class="form-group">
      <label for="csvfile">File</label>
      <input class="form-control-file" id ="csvfile" type="file" accept = ".csv">
    </div>


    <div class="form-group">
      <label for="template">Template</label>
      <select id="template"  class="form-control">
        <option value="facebook_app_only">facebook_app_only</option>
        <option value="facebook_cross_platform">facebook_cross_platform</option>
        <option value="google_cross_platform">google_cross_platform</option>
      </select>
    </div>

    <div class="form-group">
      <label for="baseURL">Base URL</label>
        <input type="text" id ="baseURL"class="form-control" placeholder="https://company.app.link/3p?"><br>
    </div>

      <input class="btn btn-primary" type="submit" value="Convert!">
    </form>
    """

    this

  onSubmit: (e) ->
    e.preventDefault()
    @logsElem.html ""
    data =
      source:  @$("#csvfile")[0].files[0].path
      template: @$("#template").val()
      baseURL: @$("#base_url").val()
      log: (data, type = 'info') =>
        @logsElem.html "<span class='#{type}'>#{data}</span>"

    return console.log "no file!" unless data.source?

    (new Converter data).process()
