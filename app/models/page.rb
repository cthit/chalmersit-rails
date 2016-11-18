class Page < ActiveRecord::Base
    translates :title, :body
    globalize_accessors

    belongs_to :parent, class_name: 'Page'
    has_many   :children, class_name: 'Page'
    validate :notOwnParent
    #validates  :title_sv, presence: true, allow_blank: false, uniqueness: { case_sensitive: true }
    #validates  :title_en, presence: true, allow_blank: false, uniqueness: { case_sensitive: true }
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
        errors.add :parent_id, 'Cannot be own parent' if self == self.parent
    end

end
