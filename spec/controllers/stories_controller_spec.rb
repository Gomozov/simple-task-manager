require 'spec_helper'

describe StoriesController do
  render_views

  describe "GET 'new'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
    
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project)
    end

    describe "failure" do

      before(:each) do
        @attr = { :user_id => @user.id, :project_id => @project.id, :story_type => "bug",
                                :description => "" }
      end

    end

    describe "success" do

    end
  end
end
