require 'spec_helper'

describe MarkdownRender do

  describe "#block_code" do
    context "normal code" do
      Given(:code) { "def square(x)\nx*x\nend" }
      Given(:language) { "ruby" }
      When(:html) { subject.block_code(code,language) }
      Then { html.should == <<-HTML
<div class=\"CodeRay\">
  <div class="code"><pre><span class="keyword">def</span> <span class="function">square</span>(x)
x*x
<span class="keyword">end</span></pre></div>
</div>
HTML
}
    end
    context "trailing white space" do
      Given(:code) { "def square(x)\nx*x\nend" }
      Given(:language) { "ruby" }
      When(:html) { subject.block_code(code,language) }
      Then { html.should == <<-HTML
<div class=\"CodeRay\">
  <div class="code"><pre><span class="keyword">def</span> <span class="function">square</span>(x)
x*x
<span class="keyword">end</span></pre></div>
</div>
HTML
      }
    end
  end
end
