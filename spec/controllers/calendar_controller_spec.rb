require 'rails_helper'

RSpec.describe CalendarController, type: :controller do

  describe "GET #fetch" do
    it "returns http success" do
      get :fetch
      expect(response).to have_http_status(:success)
    end
  end

end
