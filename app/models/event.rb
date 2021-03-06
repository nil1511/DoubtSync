# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  venue              :string(255)
#  duration           :string(255)
#  date               :datetime
#  description        :text
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  url                :string(255)
#  college_id         :integer
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Event
	include Mongoid::Document
	include Mongoid::Paperclip
	belongs_to :user
	belongs_to :college
has_mongoid_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/event.png"
validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

	default_scope -> { order('created_at DESC') }

	validates :name, presence: true
	validates :venue, presence: true
	validates :duration, presence: true
	validates :date, presence: true
	validates :description, presence: true
	validates :user_id, presence: true
	validates :college_id, presence: true

	def self.from_users_followed_by(user)
	    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        	user_id: user.id)
  	end
end
