class Post < ActiveRecord::Base
  scope :ordered, -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy
  has_one :event, dependent: :destroy

  accepts_nested_attributes_for :event, allow_destroy: true

  translates :title, :body, :slug
  globalize_accessors

  validates *globalize_attribute_names, :title, :body, :user_id, :group_id, presence: true
  validates *(globalize_attribute_names.select{|a| a.to_s.include?("title")}), length: { in: 5..70 }
  validates *(globalize_attribute_names.select{|a| a.to_s.include?("body")}), length: { in: 10..5000 }
  validates :sticky, inclusion: { in: [true, false] }
  validates :slug, uniqueness: { case_sensitive: true }, presence: true, if: 'title.present?'

  validate :user_in_group

  before_validation :generate_slug

  def previous
    Post.where('id < ?', id).order(id: :desc).first
  end

  def next
    Post.where('id > ?', id).first
  end

  def event?
    not self.event.nil?
  end

  def user
    @user ||= User.find(user_id)
  end

  def group
    @group ||= Committee.find_by(slug: group_id)
  end

  def to_param
    "#{id}-#{slug}"
  end

  private

    def generate_slug
      I18n.available_locales.each do |locale|
        # Set slug to each locale if not already set.
        Globalize.with_locale locale do
          self.slug ||= title.try(&:parameterize)
        end
      end
    end

    def user_in_group
      errors.add(:group_id, :user_not_in_group, group: group_id) unless user.groups.include? group_id
    end
end
