class Post < ActiveRecord::Base
	require "net/http"
	require "net/https"
	require "uri"
  scope :ordered, -> { order(created_at: :desc) }

  after_save :send_mail

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

  validate :user_in_group

  before_validation :generate_slug

  mount_uploader :image, ArticleImageUploader

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


    def send_mail
  
		url = URI.parse("https://beta-account.chalmers.it/applications/push-to-subscribers/1")
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		req = Net::HTTP::Get.new(url.path)
		

		req.add_field('Authorization', 'Token token=' + Rails.application.secrets.push_mail_token)
		req.add_field('push_message', self.body)
		req.add_field('push_title', self.title)
		req.add_field('push_url', Rails.application.routes.url_helpers.post_url(:id => id))
		req.add_field('push_url_title', self.title)

		response = http.request(req)	
   	end
end
