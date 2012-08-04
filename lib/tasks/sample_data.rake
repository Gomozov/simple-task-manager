namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    User.create!(:name => "admin",
                 :email => "admin@example.org",
                 :password => "nimda",
                 :password_confirmation => "nimda")
    49.times do |n|
      name  = Faker::Name.name
      email = "testuser#{n+1}@example.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end

    User.all(:limit => 20).each do |user|
      5.times do
        user.projects.create!(:title => Faker::Company.catch_phrase, :description => Faker::Lorem.sentence(5),
                              :public => true)
      end
    end

  end
end
