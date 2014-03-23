# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  role_id                :integer
#  profile_id             :integer
#


#FIXME link to student or professor

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :posts
  has_many :comments
  has_one :student
  belongs_to :role
  before_create :set_default_role
  before_create :link_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  private
  def set_default_role
    self.role ||= Role.find_by_name('student')
  end
  
  private
  def link_profile
    if self.role=='student'
      has_one :student
    elsif self.role=='professor'
      has_one :professor
    end
  end
end
