


setupPageForPost = () ->
  $(".datepicker").pickadate()

  publishState = $("#post_published")

  $("form").delegate ".confirm_save_post", "click", (e) ->
    response = confirm("Are you sure you want to save this post?")
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

  updatePreview = _.debounce(updatePreview, 200)

  postBody.on("keypress", ->
    updatePreview()
  )
  updatePreview()

  publishPost = $("#publish_post")
  publishPost.on("click", (e) ->
    isPublished = publishState.val() == "true"
    message = "Publish this post?"
    if isPublished
      message = "Unpublish this post?"
    response = confirm(message)
    if response
      if isPublished
        publishState.val("false")
      else
        publishState.val("true")
    else
      e.preventDefault()

  )


$(document).ready(setupPageForPost)
$(window).bind('page:change', setupPageForPost)
