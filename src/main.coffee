$ ->
  form = new ConvertFormView
    logsElem: $("div.logs")

  form.render().$el.appendTo $("div.form")
