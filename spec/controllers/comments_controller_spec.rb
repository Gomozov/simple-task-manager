require 'spec_helper'

describe CommentsController do
  render_views

  describe "GET 'new'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project, :user => @user)
      @story = Factory(:story, :user => @user, :project => @project)
    end
    
    it "should be successful" do
      get 'new', :story_id => @story.id
      response.should be_success
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project, :user => @user)
      @story = Factory(:story, :user => @user, :project => @project)
    end

    describe "failure" do

      before(:each) do
        @attr = {:comment => "", :story_id => @story.id, :user_id => @user.id }
      end

      it "should not create a comment" do
        lambda do
          post :create, :comment => @attr
        end.should_not change(Comment, :count)
      end

      it "should have the right title" do
        post :create, :comment => @attr
        response.should have_selector("title", :content => "Create comment")
      end

      it "should render the 'new' page" do
        post :create, :comment => @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :comment => "Comment", :story_id => @story.id, :user_id => @user.id}
      end

      it "should create a comment" do
        lambda do
          post :create, :comment => @attr
        end.should change(Comment, :count).by(1)
      end

      it "should redirect to the project page" do
        post :create, :comment => @attr
        response.should redirect_to(@project)
      end

      it "should have a flash message" do
        post :create, :comment => @attr
        flash[:success].should =~ /Comment created/i
      end
    end
  end

end  
