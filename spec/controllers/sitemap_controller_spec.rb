require 'spec_helper'

describe SitemapController do

  describe "GET 'index'" do
    Given(:published_posts) { [ "something"] }
    Given { Post.stub(:published).and_return(published_posts) }
    When { get 'index', :format => 'xml' }
    Then { response.should be_success }
    Then { assigns(:posts).should == published_posts }
  end

end
