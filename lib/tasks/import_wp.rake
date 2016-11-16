namespace :cthit do
  desc "Get an access token from account.chalmers.it"
  task import_wp: :environment do
    Post.delete_all
    client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "it_test")
    results = client.query("select it_posts.*, it_users.user_login from it_posts INNER JOIN it_users on it_users.id=it_posts.post_author where post_status='publish' and post_content!='' and post_title!='' and post_type='post'; ")
    #[:group_id, :title, :body, :sticky, :show_public, :image_upload,
    #{ event_attributes: [:event_date, :full_day, :start_time, :end_time, :facebook_link, :location, :_destroy, :organizer, :id] }]
    #+ Post.globalize_attribute_names

    results.each do |row|
      post = Post.new
      post.title = row["post_title"]
      body = Unmarkdown.parse row["post_content"]
      post.body = body
      post.slug = row["post_name"]
      post.slug_sv = row["post_name"]
      post.slug_en = row["post_name"]
      post.title_en = row["post_title"]
      post.body_en = body
      post.title_sv = row["post_title"]
      post.body_sv = body
      post.show_public = true
      post.user_id = row["user_login"]
      post.group_id = "legacy"
      post.created_at = row["post_date"]
      post.save!
    end
  end
end
