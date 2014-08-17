# == Schema Information
#
# Table name: internship_applications
#
#  id                  :integer          not null, primary key
#  internship_id       :integer
#  student_id          :integer
#  message             :text
#  resume_file_name    :string(255)
#  resume_content_type :string(255)
#  resume_file_size    :integer
#  resume_updated_at   :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

class InternshipApplication
	include Mongoid::Document
	include Mongoid::Paperclip
	has_mongoid_attached_file :resume
  	validates_attachment_content_type :resume, content_type: "application/pdf"
	belongs_to :internship
	belongs_to :student
end
