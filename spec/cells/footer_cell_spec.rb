require 'spec_helper'

describe FooterCell do

  context "cell rendering" do
    context "rendering display" do
      subject { render_cell(:footer, :display) }

      it { should include "Footer#display" }
      it { should include "Find me in app/cells/footer/display.html" }
    end

    context "rendering rspec" do
      subject { render_cell(:footer, :rspec) }

      it { should include "Footer#rspec" }
      it { should include "Find me in app/cells/footer/rspec.html" }
    end
  end

end
