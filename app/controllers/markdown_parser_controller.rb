class MarkdownParserController < ApplicationController
  def create
    markdown = params[:markdown]
    result = { html: TextParser.new(markdown).to_html }
    render json: result
  end
end
