# == Schema Information
#
# Table name: books
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  author             :string(255)
#  edition            :string(255)
#  description        :text
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  tags               :text
#  price              :integer
#  contact            :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Book < ActiveRecord::Base
	belongs_to :user

	has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/book.png"
	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  	default_scope -> { order('created_at DESC') }
  	
	validates :name, presence: true
	validates :author, presence: true
	validates :edition, presence: true
	validates :contact, presence: true
	validates :user_id, presence: true
	validates :description, presence: true

	def self.from_users_followed_by(user)
	    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        	user_id: user.id)
  	end
end
