class Slugify

  def initialize(raw_text)
    @raw_text = raw_text
  end

  def compute
    return nil unless @raw_text #TODO not happy with these two lines
    return nil if @raw_text == ""
    @raw_text.gsub(/[^\w\/]|[!\(\)\.|\/]+/, ' ') # concert special chars to spaces
             .strip # remove trailing spaces
             .downcase # fix case
             .gsub(/\ +/, '-') # concert groups of spaces to dashes
  end

end
