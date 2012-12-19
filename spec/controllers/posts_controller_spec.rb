require 'spec_helper'

describe PostsController do
  describe "#edit" do
    Given(:slug) { "my-title" }
    Given(:target_post) { stub_model(Post, {id: 42, slug: slug}) }
    Given(:update_params) { { body: "valid", title: "valid title"} }
    Given { Post.stub(:find_by_slug).with(slug).and_return(target_post) }
    context "admin is logged in" do
      Given { subject.stub(:authenticate_admin!).and_return(true) }
      context "successful update" do
        Given { target_post.stub(:update_attributes).with(any_args).and_return(true) }
        When { put :edit, id: slug, post: update_params }
        Then { response.should be_successful }
        Then { assigns(:post).should == target_post }
      end
      context "failed update" do 
        Given { target_post.stub(:update_attributes).with(any_args).and_return(true) }
        When { put :edit, id: slug, post: update_params }
        Then { response.should be_successful }
        Then { assigns(:post).should == target_post }
      end
    end
    context "no one is logged in" do
      Given { subject.stub(:current_admin).and_return(nil) }
      When { put :edit, id: slug, post: update_params }
      Then { response.code.should == "302" }
    end
  end
  describe "#edit" do
    Given(:slug) { "my-title" }
    Given(:target_post) { stub_model(Post, {id: 42, slug: slug}) }
    Given { Post.stub(:find_by_slug).with(slug).and_return(target_post) }
    context "admin is logged in" do
      Given { subject.stub(:authenticate_admin!).and_return(true) }
      When { get :edit, id: slug }
      Then { response.code.should == "200" }
      Then { response.should render_template(:edit) }
      Then { assigns(:post).should be_present }
      Then { assigns(:post).should == target_post }
    end
    context "no one is logged in" do
      Given { subject.stub(:current_admin).and_return(nil) }
      When { get :edit, id: slug }
      Then { response.code.should == "302" }
    end
  end
  describe "#new" do
    context "admin is logged in" do
      Given { subject.stub(:authenticate_admin!).and_return(true) }
      When { get :new }
      Then { response.code.should == "200" }
      Then { response.should render_template(:new) }
      Then { assigns(:post).should be_present }
    end
    context "no one is logged in" do
      Given { subject.stub(:current_admin).and_return(nil) }
      When { get :new }
      Then { response.code.should == "302" }
    end
  end
  describe "#create" do
    context "admin is logged in" do
      Given { subject.stub(:authenticate_admin!).and_return(true) }
      context "valid post" do
        Given(:valid_post) { { body: "valid", title: "valid title"} }
        When { post :create, post: valid_post }
        Then { response.should redirect_to(post_path(assigns(:post).id)) }
      end
    end
    context "no one is logged in" do
      Given { subject.stub(:current_admin).and_return(nil) }
      When { post :create }
      Then { response.code.should == "302" }
    end
  end
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
    context "find by id" do
      Given(:id) { "9" }
      Given(:target_post) { stub_model(Post, {id: id} )}
      Given { Post.stub(:find_by_slug).with(any_args()).and_return(nil) }
      Given { Post.stub(:find).with(id).and_return(target_post) }
      context "admin is logged in" do
        Given { subject.stub(:current_admin).and_return(stub_model(Admin)) }
        When { get :show, id: id }
        Then { response.should be_successful }
        Then { response.should render_template(:show) }
        Then { assigns(:post).should == target_post }
      end
      context "no one is logged in" do
        When(:result) { get :show, id: id }
        Then { result.should have_failed(ActiveRecord::RecordNotFound, //) }
      end
    end
    context "find by slug" do
      Given(:slug) { "my-title" }
      Given(:target_post) { stub_model(Post, slug: slug) }
      context "post found" do
        Given { Post.stub(:find_by_slug).and_return(target_post) }
        When { get :show, id: slug }
        Then { response.should be_successful }
        Then { response.should render_template(:show) }
        Then { assigns(:post).should == target_post }
      end
      context "post not found" do
        Given { Post.stub(:find_by_slug).with(any_args()).and_return(nil) }
        When(:result) { get :show, id: slug }
        Then { result.should have_failed(ActiveRecord::RecordNotFound, //) }
      end
    end
  end
end
