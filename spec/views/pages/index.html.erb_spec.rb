require 'rails_helper'

RSpec.describe "pages/index", :type => :view do
  before(:each) do
    assign(:pages, [
      Page.create!(),
      Page.create!()
    ])
  end

  it "renders a list of pages" do
    render
  end
end
