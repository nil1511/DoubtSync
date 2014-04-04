# == Schema Information
#
# Table name: comments
#
#  id                    :integer          not null, primary key
#  text                  :text
#  tagged_users          :text
#  htags                 :text
#  user_id               :integer
#  post_id               :integer
#  spam                  :string(255)
#  upvotes               :text
#  downvotes             :text
#  document_file_name    :string(255)
#  document_content_type :string(255)
#  document_file_size    :integer
#  document_updated_at   :datetime
#  created_at            :datetime
#  updated_at            :datetime
#

class Comment < ActiveRecord::Base
	belongs_to :post
	belongs_to :user

	validates :text, presence: true
	validates :user_id, presence: true
	validates :post_id, presence: true
end
