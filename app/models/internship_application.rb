class InternshipApplication < ActiveRecord::Base
	belongs_to :internship
	belongs_to :student
end
