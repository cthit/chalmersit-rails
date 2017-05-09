require 'rails_helper'

@smurf = FactoryGirl.build(:user)
ActiveResource::HttpMock.respond_to do |mock|
  mock.post   "/users.json",   {"Content-Type"=>"application/json", "authorization"=>"Bearer "}, @smurf.to_json, 201, "Location" => "/users/smurf.json"
  mock.get    "/users/smurf.json", {"Accept"=>"application/json", "authorization"=>"Bearer "}, @smurf.to_json
end

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "The #{factory_name} factory" do
    it 'is valid' do
      expect(build(factory_name)).to be_valid
    end
  end
end
