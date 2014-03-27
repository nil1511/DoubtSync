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
#  profile_id             :integer
#  role_id                :integer
#  college_id             :integer
#  created_at             :datetime
#  updated_at             :datetime
#

#FIXME link to student or professor

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
#   validates :email, presence: true
#   validates :username, presence: true

  validates :username,
  :uniqueness => {:case_sensitive => false}

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  belongs_to :college
  belongs_to :role

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  
  has_many :followers, through: :reverse_relationships, source: :follower

  before_create :set_default_role

  after_create :link_profile
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def profile
    if self.role=='student'
      Student.find_by(user_id: self.id)
    elsif self.role=='professor'
      Professor.find_by(user_id: self.id)
    end
  end

  def set_role(new_role)
    self.role ||= Role.find_by_name(new_role)
  end

  private
  def set_default_role
    self.role ||= Role.find_by_name('student')
  end

  def link_profile
    if self.role.name=='student' or self.role.name=='ambassador'
      student = Student.new(:user_id => self.id)
      student.save

    elsif self.role.name=='professor'
      professor = Professor.new(:user_id => self.id)
      professor.save
    end
  end

end
