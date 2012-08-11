Factory.define :user do |user|
  user.name                  "Test"
  user.email                 "test@example.com"
  user.password              "test"
  user.password_confirmation "test"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :project do |project|
  project.title              "Test"
  project.description        "Test description"
  project.public             true
  project.association :user
end

Factory.define :story do |story|
  story.description          "Test description"
  story.story_type           "feature"
  story.association :user
  story.association :project
end

Factory.define :comment do |comment|
  comment.comment            "Test comment"
  comment.user_id :user
  comment.story_id :story
end
