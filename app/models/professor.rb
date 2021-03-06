# == Schema Information
#
# Table name: professors
#
#  id                  :integer          not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  mobile              :string(255)
#  gender              :boolean
#  dob                 :date
#  spamrate            :integer
#  user_id             :integer
#  aoi                 :text
#  resume_file_name    :string(255)
#  resume_content_type :string(255)
#  resume_file_size    :integer
#  resume_updated_at   :datetime
#  topics_covered      :text
#  created_at          :datetime
#  updated_at          :datetime
#

class Professor
	include Mongoid::Document
	include Mongoid::Paperclip
	belongs_to :user
	has_many :internships
	#validates_format_of :mobile, :with => /(7|8|9)\d{9}/, :message => "Invalid Mobile Number"

end
