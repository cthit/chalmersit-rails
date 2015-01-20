class Page < ActiveRecord::Base
    belongs_to :parent, class_name: 'Page'
    has_many   :children, class_name: 'Page'
    validates  :title, presence: true, allow_blank: false, uniqueness: { case_sensitive: true }
    validates  :body, presence: true, allow_blank: false
    validates  :slug, allow_blank: false, uniqueness: { case_sensitive: true }, presence: true

    before_validation :generate_slug
    
    def to_param
        slug
    end

    def generate_slug
        self.slug ||= title.try(&:parameterize)
    end
end
