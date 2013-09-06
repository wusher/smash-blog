class MarkdownRender < Redcarpet::Render::HTML

  def block_code(code, language)
    CodeRay.scan(clean(code),language).div(css: :class)
  end

  private

  def clean(code)
    code.rstrip
  end

end
