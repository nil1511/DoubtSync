# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  name       :text
#  group      :text
#  created_at :datetime
#  updated_at :datetime
#

class Topic < ActiveRecord::Base
	validates :name, presence: true

	has_many :topic_posts
	has_many :posts, through: :topic_posts

	has_many :followed_topics
	has_many :users, through: :followed_topics
	# belongs_to :user
end
