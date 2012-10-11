class TextParser

  def initialize(markdown)
    @markdown = markdown
  end

  def to_html
     Redcarpet::Markdown.new(MarkdownRender, fenced_code_blocks: true).render(@markdown)
  end

end
