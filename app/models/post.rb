class Post < ActiveRecord::Base
  scope :ordered, -> { order(created_at: :desc) }

  has_many :comments, dependent: :destroy
  has_one :event, dependent: :destroy
  belongs_to :group, class_name: 'Committee'

  accepts_nested_attributes_for :event, allow_destroy: true

  translates :title, :body, :slug
  globalize_accessors

  validates *globalize_attribute_names, :user_id, :group_id, presence: true, allow_blank: false
  validates *(globalize_attribute_names.select{|a| a.to_s.include?("title")}), length: { in: 5..70 }
  validates *(globalize_attribute_names.select{|a| a.to_s.include?("body")}), length: { in: 10..5000 }
  validates :sticky, inclusion: { in: [true, false] }
  validates :slug, uniqueness: { case_sensitive: true }, presence: true, if: 'title.present?'
  validate :documents_extension
  validate :user_in_group

  before_validation :generate_slug

  mount_uploader :image, ArticleImageUploader
  mount_uploaders :documents, DocumentUploader
  serialize :documents, JSON

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

  def image_upload=(file)
    uploader = ArticleImageUploader.new
    uploader.store!(file)
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
      errors.add(:group_id, :user_not_in_group, group: group.title) unless user.committees.include? group
    end

    def documents_extension
      documents.each do |doc|
        unless %w{pdf md txt}.include?(doc.file.extension)
          errors.add(:documents, "Includes unsupport file format (only pdf/md/txt)")
        end
      end
    end
end
