class Post < ActiveRecord::Base
  scope :ordered, -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy
  has_one :event, dependent: :destroy
  belongs_to :group, class_name: 'Committee'

  accepts_nested_attributes_for :event, allow_destroy: true

  translates :title, :body, :slug
  globalize_accessors

  validates *globalize_attribute_names, :user_id, :group_id, presence: true, allow_blank: false
  validates *(globalize_attribute_names.select{|a| a.to_s.include?("title")}), length: { in: 3..100 }
  validates *(globalize_attribute_names.select{|a| a.to_s.include?("body")}), length: { in: 10..10000 }
  validates :sticky, inclusion: { in: [true, false] }
  validate :user_in_group

  before_validation :generate_slug

  def previous(current_user)
    Pundit.policy_scope(current_user, Post).where('id < ?', id).order(id: :desc).first
  end

  def next(current_user)
    Pundit.policy_scope(current_user, Post).where('id > ?', id).first
  end

  def event?
    self.event.present?
  end

  def user
    begin
      @user ||= User.find(user_id)
    rescue
      @user = User.new(id: user_id, display_name: user_id)
    end
  end

  def group
    @group ||= Committee.find_by(slug: group_id)
  end

  def to_param
    "#{id}-#{slug}"
  end

  def image_upload=(file)
    uploader = ArticleImageUploader.new
    uploader.store!(file)
  end

  private

    def generate_slug
      I18n.available_locales.each do |locale|
        # Set slug to each locale if not already set.
        Globalize.with_locale locale do
          if eval("self.slug_#{locale}.nil?")
            self.send("slug_#{locale}=", title.try(&:parameterize))
          end
        end
      end
    end

    def user_in_group
      #errors.add(:group_id, :user_not_in_group, group: group.title) unless user.committees.include? group
    end
end
