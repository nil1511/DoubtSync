# == Schema Information
#
# Table name: professor_pending_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  college_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class ProfessorPendingList < ActiveRecord::Base
end
