require 'spec_helper'

describe MarkdownRender do

  describe "#block_code" do
    Given(:code) { 'def square(x)\nx*x\nend' }
    Given(:language) { "ruby" }
    When(:html) { subject.block_code(code,language) }
    Then { html.should == """<div class=\"CodeRay\">
  <div class=\"code\"><pre><span class=\"keyword\">def</span> <span class=\"function\">square</span>(x)<span class=\"error\">\\</span>nx*x<span class=\"error\">\\</span>nend</pre></div>
</div>
""" }
  end
end
