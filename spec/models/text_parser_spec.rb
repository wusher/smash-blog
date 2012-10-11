require 'spec_helper'


describe TextParser do
  
  context "basic markdown" do
    Given(:markdown) { """
# header 1 

* one
* two
* three
    """ }
     When(:html) {TextParser.new(markdown).to_html }
     Then { html.strip.should == """ 
  <h1>header 1</h1>

<ul>
<li>one</li>
<li>two</li>
<li>three</li>
</ul>
   """.strip} 
   end
   context "code in the markdown" do 
     Given(:markdown) { """
# header 1 

```ruby
code
```
    """ }
     Given { MarkdownRender.any_instance.stub(:block_code).and_return("code") }
     When(:html) {TextParser.new(markdown).to_html }
     Then { html.strip.should == "<h1>header 1</h1>\ncode"} 
   end

end
