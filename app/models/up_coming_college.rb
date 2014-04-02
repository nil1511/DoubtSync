# == Schema Information
#
# Table name: up_coming_colleges
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class UpComingCollege < ActiveRecord::Base

  validates :name, presence: true,
  :uniqueness => {:case_sensitive => false}

  validates :email, presence: true, 
  :uniqueness => {:case_sensitive => false}
  
  validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  

end
