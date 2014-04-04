# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Adding Roles'
['student','professor','ambassador','blocked'].each do |role|
  Role.find_or_create_by_name role
end
puts 'Added Roles'

puts 'Adding Colleges'
['DA-IICT','Testing'].each do |college|
  College.find_or_create_by_name college
end
puts 'Added Colleges'

puts 'Adding ambassador'
u=User.create(:email => 'atest1@daiict.ac.in', :password => 'qwerqwer',
      :password_confirmation => 'qwerqwer', :role_id => 3,
      :username => 'atest1', :college_id => 1);
s=Student.find_by_user_id(u.id)
s.first_name = "Atest1"
s.last_name = "ltest1"
s.save

u=User.create(:email => 'atest2@daiict.ac.in', :password => 'qwerqwer',
      :password_confirmation => 'qwerqwer', :role_id => 3,
      :username => 'atest2', :college_id => 2);
s=Student.find_by_user_id(u.id)
s.first_name = "Atest1"
s.last_name = "ltest1"
s.save

puts 'Added ambassador'

puts 'Adding Users'
u=User.create(:email => 'test1@daiict.ac.in', :password => 'qwerqwer',
      :password_confirmation => 'qwerqwer', :role_id => 1,
      :username => 'test1', :college_id => 1);
s=Student.find_by_user_id(u.id)
s.first_name = "Atest2"
s.last_name = "ltest2"
s.save
u=User.create(:email => 'test2@daiict.ac.in', :password => 'qwerqwer',
      :password_confirmation => 'qwerqwer', :role_id => 1,
      :username => 'test2', :college_id => 2);
s=Student.find_by_user_id(u.id)
s.first_name = "test1"
s.last_name = "ltest1"
s.save
puts 'Added Users'

puts 'Adding professor'
u=User.create(:email => 'ptest1@daiict.ac.in', :password => 'qwerqwer',
      :password_confirmation => 'qwerqwer', :role_id => 2,
      :username => 'ptest1', :college_id => 2);

s=Professor.find_by_user_id(u.id)
s.first_name = "ptest1"
s.last_name = "ltest1"
s.save
u=User.create(:email => 'ptest2@daiict.ac.in', :password => 'qwerqwer',
      :password_confirmation => 'qwerqwer', :role_id => 2,
      :username => 'ptest2', :college_id => 1);
s=Professor.find_by_user_id(u.id)
s.first_name = "ptest2"
s.last_name = "ltest2"
s.save
puts 'Added professor'

puts 'Adding Topics'
['Soft Engineering','Coding Thoery','Basic Electronic Circuits','Calculus and Complex Variables','Communication Skills','ICT for Freshers','Introduction to Programming'].each do |topic|
  Topic.find_or_create_by_name topic
end
puts 'Added Topics'