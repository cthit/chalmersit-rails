class Menu < ActiveRecord::Base
  has_many :links, class_name: 'MenuLink'
end
