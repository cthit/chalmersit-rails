require 'rails_helper'

RSpec.describe "pages/new", :type => :view do
  before(:each) do
    assign(:page, Page.new())
  end

  it "renders new page form" do
    render

    assert_select "form[action=?][method=?]", pages_path, "post" do
    end
  end
end
