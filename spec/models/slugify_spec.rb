require 'spec_helper'


describe Slugify do
  When(:slug) { Slugify.new(title).compute }
  context "nil" do
    Given(:title) { nil }
    Then { slug.should be_nil }
  end
  context "empty string" do
    Given(:title) { "" }
    Then { slug.should be_nil }
  end
  context "input has spaces" do
    Given(:title) { "this has spaces" }
    Then { slug.should == "this-has-spaces" }
  end
  context "input has leading and trailing spaces" do
    Given(:title) { " trailing spaces " }
    Then { slug.should == "trailing-spaces" }
  end
  context "input has special character" do
    Given(:title) { "title!@\\#\$%^&*()+=[]{}|\:;"'<,>.?/text' }
    Then { slug.should == "title-text" }
  end
  context "input is mixed case" do
    Given(:title) { "mIxEd CaSe" }
    Then { slug.should == "mixed-case" }
  end
end
