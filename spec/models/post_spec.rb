require 'spec_helper'

describe Post do
  Given(:post)  { Post.new title: "title"  }

  describe "#publish" do 
    Given { post.title = "has a title" }
    context "publish sucesseds" do 
      When(:is_published) { post.publish }
      Then { is_published.should be_true}
      Then { post.published?.should be_true}
      Then { post.pubdate.should_not be_nil }
    end
    context "publish fails" do 
      context "title is a duplicate" do 
        Given { post.dup.publish! }
        When(:is_published) { post.publish }
        Then  { is_published.should be_false }
      end

      context "title is empty" do 
        Given { post.title = "" }
        When(:is_published) { post.publish }
        Then  { is_published.should be_false }
      end
    end
  end

  describe "#save" do 
    When { post.save }
    describe "#slug"  do
      context "title is empty" do 
        Given { post.title = "" }
        Then { post.slug.should == "" }
      end
      context "title has text" do 
        Given { post.title = "a title" }
        Then { post.slug.should == "a-title" }
      end
    end
    describe "#body_html" do
      context "body is empty"  do
        Given { post.body = "" }
        Then { post.body_html.should == "" }
      end
      context "body has markdown" do 
        Given { post.body = "__text__" } 
        Then { post.body_html.should == "<p><strong>text</strong></p>\n" }
      end
    end
  end
  describe "#slugify" do
    When(:slug) { post.slugify(title) }
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
end
