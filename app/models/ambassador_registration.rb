# == Schema Information
#
# Table name: ambassador_registrations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  email        :string(255)
#  authcode     :string(255)
#  college_name :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class AmbassadorRegistration
	include Mongoid::Document
	validates :email, presence: true
	validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	validates :authcode, presence: true
	validates :college_name, presence: true
end
