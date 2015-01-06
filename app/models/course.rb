class Course < ActiveRecord::Base
    has_and_belongs_to_many :periods
    translates :name, :description
    globalize_accessors

    validates :code, presence: true
    validates :name, presence: true
    validates :year, numericality: { only_integer: true , greater_than: 0 , less_than: 6}, allow_blank: true

    def to_param
      code
    end

end
