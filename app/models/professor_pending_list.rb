# == Schema Information
#
# Table name: professor_pending_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  authcode   :string(255)
#  college_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProfessorPendingList < ActiveRecord::Base
	validates :email, presence: true
	validates :college_id, presence: true
	validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
	#validates :name, presence: true
end
