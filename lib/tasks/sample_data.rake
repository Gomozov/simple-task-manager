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

    User.all.each do |user|
      5.times do
        user.projects.create!(:title => Faker::Company.catch_phrase, :description => Faker::Lorem.sentence(5),
                              :public => true)
      end
    end
 
    story_types = ["bug", "release", "feature", "chore"]
    User.all.each do |user|
      user.projects.each do |project|
        3.times do
          user.stories.create!(:description => Faker::Company.catch_phrase, :project_id => project.id, :responsible => user.id, :story_type => story_types[rand(story_types.size)])
        end
      end
    end

    Story.all.each do |story|
      story.comments.create!(:comment => Faker::Lorem.sentence(5), :user_id => story.user.id)
    end

  end
end
