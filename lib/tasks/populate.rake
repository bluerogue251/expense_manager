require "factory_girl"

namespace :db do
  desc "Add fake sample data to the database"
  task populate: :environment do
    # FactoryGirl.find_definitions
    # include FactoryGirl::Syntax::Methods


    CATEGORIES  = Category.all
    DEPARTMENTS = Department.all
    JOB_TITLES  = JobTitle.all

    def create_1000_expenses(user)
      100.times do
        FactoryGirl.create(:expense, user: user, category: CATEGORIES.sample)
      end
    end

    i = 1

    puts "teddy"
    teddy = User.create!(name: 'Teddy Widom', email: 'theodore.widom@gmail.com', password: 'password')
    create_1000_expenses(teddy)

    10.times do
      puts i
      user = FactoryGirl.create(:user)
      create_1000_expenses(user)
      i += 1
    end

    User.all.each do |user|
      puts user.name
      FactoryGirl.create(:job_title_assignment, user: user, job_title: JOB_TITLES.sample, department: DEPARTMENTS.sample, starts_on: '1995-01-01', ends_on: '2013-12-31')
      FactoryGirl.create(:job_title_assignment, user: user, job_title: JOB_TITLES.sample, department: DEPARTMENTS.sample, starts_on: '2014-01-01', ends_on: '2015-01-01')
    end
  end
end


