require 'spec_helper'

describe MarkdownParserController do

  describe "post create" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
    it "returns an html version of the markdown" do
      markdown = "some markdown" 
      post 'create', markdown: markdown
      response.body.should == { html: "<p>#{markdown}</p>\n" }.to_json
    end
  end

end
