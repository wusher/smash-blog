require 'spec_helper'

describe Post do
  Given(:post)  { Post.new title: "title"  }

  describe "#default_scope" do
    Given!(:last_and_oldest)  { Post.create!(pubdate: 2.months.ago) }
    Given!(:first_and_newest) { Post.create!(pubdate: 1.months.ago) }
    When(:found_posts) { Post.all }
    Then { found_posts.first.should == first_and_newest }
    Then { found_posts.last.should  == last_and_oldest }
    context "nonpublished post exists" do
      Given!(:nonpublished) { Post.create! }
      When(:found_posts) { Post.all }
      Then { found_posts.first.should == nonpublished }
      Then { found_posts.last.should  == last_and_oldest }
    end
  end

  describe "#published" do
    Given!(:published) { Post.create! published: true, title: "stuff", pubdate: Time.now  }
    Given!(:nonpublished) { Post.create! published: false }
    When(:posts) { Post.published }
    Then { posts.count.should == 1 }
    Then { posts.first == published }
  end
  
  describe "#recent" do 

  end

  describe "#publish" do
    Given { post.title = "has a title" }
    context "publish succeeds" do
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

  describe "#publish!" do
    context "publish succeeds" do
      Given { post.stub(:publish).and_return(true) }
      When(:is_published) { post.publish! }
      Then { is_published.should be_true}
    end
    context "publish fails" do
      Given { post.stub(:publish).and_return(false) }
      When(:result) { post.publish! }
      Then { result.should have_failed(ActiveRecord::RecordInvalid,//)}
    end

  end

  describe "#save" do
    When { post.save }
    describe "#slug"  do
      context "title is empty" do
        Given { post.title = "" }
        Then { post.slug.should == nil }
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
end
