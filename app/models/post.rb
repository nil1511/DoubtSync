# == Schema Information
#
# Table name: posts
#
#  id                 :integer          not null, primary key
#  text               :string(255)
#  tag                :text
#  visibility_to_prof :boolean
#  spamrate           :integer
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
end
