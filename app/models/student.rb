# == Schema Information
#
# Table name: students
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  mobile              :string(255)
#  gender              :boolean
#  dob                 :date
#  degree              :string(255)
#  graduate_year       :integer
#  spamrate            :integer
#  user_id             :integer
#  resume_file_name    :string(255)
#  resume_content_type :string(255)
#  resume_file_size    :integer
#  resume_updated_at   :datetime
#  aoi                 :text
#  created_at          :datetime
#  updated_at          :datetime
#

class Student
	include Mongoid::Document
	include Mongoid::Paperclip
	#validates :name, presence: true
	belongs_to :user
	has_many :internship_applications
	#validates_format_of :mobile, :with => /(7|8|9)\d{9}/, :message => "Invalid Mobile Number"
end
