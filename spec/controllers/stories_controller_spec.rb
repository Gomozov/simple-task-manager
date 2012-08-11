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
      
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Create story")
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :project_id => @project.id, :story_type => "bug", :description => "" }
      end

      it "should not create a story" do
        lambda do
          post :create, :story => @attr
        end.should_not change(Story, :count)
      end

      it "should have the right title" do
        post :create, :story => @attr
        response.should have_selector("title", :content => "Create story")
      end

      it "should render the 'new' page" do
        post :create, :story => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :project_id => @project.id, :story_type => "bug", :description => "Description"}
      end

      it "should create a story" do
        lambda do
          post :create, :story => @attr
        end.should change(Story, :count).by(1)
      end

      it "should redirect to the project page" do
        post :create, :story => @attr
        response.should redirect_to(@project)
      end

      it "should have a flash message" do
        post :create, :story => @attr
        flash[:success].should =~ /Story created/i
      end
    end

  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project, :user => @user)
      @story = Factory(:story, :user => @user, :project => @project)
    end

    describe "failure" do

      before(:each) do
        @attr = { :project_id => "", :story_type => "", :description => ""}
      end

      it "should redirect_to the project page" do
        put :update, :id => @story, :story => @attr
        response.should redirect_to(root_path)
      end

    end

    describe "success" do

      before(:each) do
        @attr = { :project_id => @project.id, :story_type => "release", :description => "Description"}
      end

      it "should change the stories attributes" do
        put :update, :id => @story, :story => @attr
        @story.reload
        @story.description.should  == @attr[:description]
        @story.story_type.should == @attr[:story_type]
        @story.state.should == "not_yet_started"
      end

      it "should redirect to the project page" do
        put :update, :id => @story, :story => @attr
        response.should redirect_to(@project)
      end

    end
  end

end
