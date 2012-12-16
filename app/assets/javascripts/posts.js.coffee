$(->
  $(".datepicker").pickadate()



  # for creating a form 
  postBody = $("#post_body")
  bodyPreview = $("#preview")

  updatePreview = ->
    markdown = postBody.val()
    data = { markdown: markdown }

    $.ajax({
      url: '/markdown_parser',
      dataType: 'json',
      type: "POST",
      data: data,
      success: (data, textStatus, jqXHR) ->
        newMarkdown = data["html"]
        bodyPreview.html(newMarkdown)
      })

  updatePreview = _.debounce(updatePreview, 1000)

  postBody.on("keypress", ->
    updatePreview()
  )
)
