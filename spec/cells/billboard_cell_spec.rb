require 'spec_helper'

describe BillboardCell do

  context "cell rendering" do
    context "rendering display" do
      subject { render_cell(:billboard, :display) }

      it { should include "Billboard#display" }
      it { should include "Find me in app/cells/billboard/display.html" }
    end

    context "rendering rspec" do
      subject { render_cell(:billboard, :rspec) }

      it { should include "Billboard#rspec" }
      it { should include "Find me in app/cells/billboard/rspec.html" }
    end
  end

end
