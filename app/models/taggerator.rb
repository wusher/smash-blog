class Taggerator

  def initialize(post)
    @post = post
  end

  def invoke(tag_names)
    return unless tag_names.present?
    tag_names = clean_tag_names(tag_names)
    tags = build_tag_names(tag_names)
    @post.tags = tags 
  end

  def clean_tag_names(tag_names)
    
    if tag_names.respond_to?(:to_ary)
      tag_names.to_ary
    else
      tag_names.split(", ")
    end
  end

  def build_tag_names(tag_names)
    tag_names.map do |name|
      Tag.find_by_name(name) || Tag.create!(name: name)
    end
  end
end
