require 'active_resource'
class User < ActiveResource::Base
  self.site = "http://10.0.0.219:3000"
end
