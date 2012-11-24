require 'spec_helper'


describe PostsController do
  describe "#index" do
    context "admin is logged in" do
      Given(:all_posts) { [ stub_model(Post), stub_model(Post)] } 
      Given { Post.stub(:all).and_return(all_posts) }
      Given { subject.stub(:current_admin).and_return(stub_model(Admin)) }
      When { get :index }  
      Then { response.code.should == "200" }
      Then { response.should render_template(:index) }
      Then { assigns(:posts).should == all_posts }
    end
    context "no one is logged in" do 
      Given(:published_posts) { [ stub_model(Post), stub_model(Post)] } 
      Given { Post.stub(:published).and_return(published_posts) }
      Given { subject.stub(:current_admin).and_return(nil) }
      When { get :index }  
      Then { response.code.should == "200" }
      Then { response.should render_template(:index) }
      Then { assigns(:posts).should == published_posts }
    end
  end

  describe "#show" do
    context "post exists" do
      Given(:slug) { "my-title" }
      Given(:target_post) { stub_model(Post, slug: slug) }
      Given { Post.stub(:find_by_slug).and_return(target_post) }
      When { get :show, id: target_post.slug }
      Then { response.code.should == "200" }
      Then { response.should render_template(:show) }
      Then { assigns(:post).should == target_post }
    end

    context "post not found" do
      Given { Post.stub(:find_by_slug).and_return(nil) }
      When(:result) { get :show, id: "anything" }
      Then { result.should have_failed(ActiveRecord::RecordNotFound, //) }
    end
  end


end
