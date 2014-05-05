require 'spec_helper'

describe LoggerCell do

  context "cell rendering" do
    context "rendering display" do
      subject { render_cell(:logger, :display) }

      it { should include "Logger#display" }
      it { should include "Find me in app/cells/logger/display.html" }
    end

    context "rendering rspec" do
      subject { render_cell(:logger, :rspec) }

      it { should include "Logger#rspec" }
      it { should include "Find me in app/cells/logger/rspec.html" }
    end
  end

end
