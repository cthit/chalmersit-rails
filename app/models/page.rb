class Page < ActiveRecord::Base

    def self.page_admins
      %w(styrit armit snit)
    end

    translates :title, :body
    globalize_accessors

    belongs_to :parent, class_name: 'Page'
    has_many   :children, class_name: 'Page'
    validate :notOwnParent
    validates  *globalize_attribute_names, presence: true, allow_blank: false
    validates  :slug, allow_blank: false, uniqueness: { case_sensitive: true }, presence: true

    before_validation :generate_slug

    def to_param
        slug
    end

    def generate_slug
        self.slug ||= title.try(&:parameterize)
    end

    def notOwnParent
        parentRecursive self
    end


    def parentRecursive page
        if page.parent == self
            errors.add :parent_id, 'Cannot be own parent'
        else
            parentRecursive page.parent unless page.parent.nil?
        end
    end

end
