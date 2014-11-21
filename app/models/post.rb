class Post < ActiveRecord::Base
	validates_presence_of :title, :body, :user_id
	validates_length_of :title, in: 5..50
	validates_length_of :body, in: 10..500
	validates_inclusion_of :sticky, in: [true, false]
end
