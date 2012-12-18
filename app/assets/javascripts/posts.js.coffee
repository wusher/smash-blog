


$(->
  $(".datepicker").pickadate()
  $("form").delegate ".confirm_save_post", "click", (e) ->
    response = confirm("Are you sure you want to publish this post?")
    unless response
      e.preventDefault()
      
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

  publishPost = $("#publish_post")
  publishState = $("#publish")
  publishPost.on("click", (e) ->
    if publishState.val() == "true"
      publishState.val("false")
    else
      publishState.val("true")
  )
)
