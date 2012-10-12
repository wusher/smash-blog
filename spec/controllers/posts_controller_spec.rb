require 'spec_helper'


describe PostsController do 
  
  describe "#index" do 
    it "works" do
      posts = [ stub_model(Post), stub_model(Post)]
      Post.stub(:all).and_return(posts)
      get :index
      
      response.code.should == "200"
      response.should render_template(:index)
      assigns(:posts).should == posts
      


    end

  end

  describe "#show" do
    it "successful request" do 
      slug = "my-title"
      post = stub_model(Post, slug: slug)
      Post.stub(:find_by_slug).and_return(post)
      get :show, id: post.slug 
      response.code.should == "200"
      assigns(:post).should == post
    end
    context "post not found" do 
      Given { Post.stub(:find_by_slug).and_return(nil) }
      When(:result) { get :show, id: "anything" }
      Then { result.should have_failed(ActiveRecord::RecordNotFound, //) }
    end
  end


end 
