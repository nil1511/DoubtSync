# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  text               :string(255)
#  tagged_users       :text
#  htags              :text
#  visibility_to_prof :boolean
#  spamrate           :integer
#  user_id            :integer
#  upvotes            :string(255)
#  downvotes          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
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
