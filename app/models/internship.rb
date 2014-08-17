# == Schema Information
#
# Table name: internships
#
#  id                :integer          not null, primary key
#  professor_id      :integer
#  title             :text
#  description       :text
#  tags              :text
#  start_date        :date
#  duration          :text
#  location          :text
#  deadline          :date
#  opening           :text
#  url               :text
#  eligible_students :text
#  required_skills   :text
#  created_at        :datetime
#  updated_at        :datetime
#

class Internship
	include Mongoid::Document
	belongs_to :professor
	has_many :internship_applications
end
