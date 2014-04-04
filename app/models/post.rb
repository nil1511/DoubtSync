# == Schema Information
#
# Table name: posts
#
#  id                    :integer          not null, primary key
#  text                  :text
#  tagged_users          :text
#  htags                 :text
#  visibility_to_prof    :boolean
#  spam                  :string(255)
#  user_id               :integer
#  upvotes               :text
#  downvotes             :text
#  document_file_name    :string(255)
#  document_content_type :string(255)
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime
#  updated_at            :datetime
#

class Post < ActiveRecord::Base
	belongs_to :user
	
	has_many :comments

	has_many :topic_posts
	has_many :topics, through: :topic_posts

  	default_scope -> { order('created_at DESC') }

	validates :text, presence: true
	validates :user_id, presence: true

	def self.from_users_followed_by(user)
	    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        	user_id: user.id)
  	end
end
