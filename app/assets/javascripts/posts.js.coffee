


setupPageForPost = () ->
  $(".datepicker").pickadate()

  publishState = $("#post_published")

  $("form").delegate ".confirm_save_post", "click", (e) ->
    response = confirm("Are you sure you want to save this post?")
    unless response
      e.preventDefault()

  $("form").delegate "textarea" , "keydown", (e) ->
    return unless e.keyCode == 9
    e.preventDefault()

    start = @selectionStart
    end = @selectionEnd
    self = $(this)
    value = self.val()

    self.val "#{value.substring(0,start)}  #{value.substring(end)}"
    @selectionStart = @selectionEnd = start + 2
    _.defer ()-> self.trigger("keypress")

  $("form").delegate "textarea" , "keydown", (e) ->
    return unless e.keyCode == 8
    self = $(this)
    _.defer ()-> self.trigger("keypress")


      
  # for creating a form 
  postBody = $("#post_body")
  bodyPreview = $("#preview")

  updatePreview = ->
    markdown = postBody.val()
    return unless markdown
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

  updatePreview = _.debounce(updatePreview, 150)

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
