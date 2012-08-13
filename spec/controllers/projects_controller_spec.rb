require 'spec_helper'

describe ProjectsController do
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
      response.should have_selector("title", :content => "New project")
    end
  end

  describe "POST 'create'" do
    
    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :title => "", :description => "" }
      end

      it "should not create a project" do
        lambda do
          post :create, :project => @attr, :user => @user
        end.should_not change(Project, :count)
      end

      it "should have the right title" do
        post :create, :user => @user, :project => @attr
        response.should have_selector("title", :content => "New project")
      end

      it "should render the 'new' page" do
        post :create, :user => @user, :project =>  @attr
        response.should render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "New Project", :description => "Description"}
      end

      it "should create a project" do
        lambda do
          post :create, :user => @user, :project =>  @attr
        end.should change(Project, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @user, :project => @attr, :id => @user.id
        response.should redirect_to(user_path(@user))
      end

      it "should have a welcome message" do
        post :create, :project => @attr, :user => @user
        flash[:success].should =~ /created/i
      end

    end

  end

  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project, :user => @user)
    end

    it "should be successful" do
      get :edit, :id => @project
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @project
      response.should have_selector("title", :content => "Edit project")
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @project = Factory(:project, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :title => "", :description => ""}
      end

      it "should render the 'edit' page" do
        put :update, :id => @project, :project => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @project, :project => @attr
        response.should have_selector("title", :content => "Edit project")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "New Name", :description => "Test description" }
      end

      it "should change the project's attributes" do
        put :update, :id => @project, :project => @attr
        @project.reload
        @project.title.should  == @attr[:title]
        @project.description.should == @attr[:description]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :project => @attr, :user => @user
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @project, :project => @attr
        flash[:success].should =~ /updated/
      end
    end
  end
  
describe "DELETE 'destroy'" do

  before(:each) do
    @user = Factory(:user)
    test_sign_in(@user)
    @project = Factory(:project, :user => @user)
  end

    it "should destroy the project" do
      lambda do
        delete :destroy, :id => @project
      end.should change(Project, :count).by(-1)
    end

    it "should redirect to the user page" do
      delete :destroy, :id => @project
      response.should redirect_to(user_path(@user))
    end
end

  describe "GET 'show'" do
  
    describe "for non-signed-in users" do
    
      before(:each) do
        @user = Factory(:user)
        @project = Factory(:project, :user => @user)
      end

      it "should deny access" do
        get :show, :id => @project
        response.should redirect_to(signin_path)
        flash[:info].should =~ /login and password/i
      end
    end

    describe "for signed-in users" do
     
      before(:each) do
        @user = Factory(:user)
        test_sign_in(@user)
        @project = Factory(:project, :user => @user)
      end

      it "should be successful" do
        get :show, :id => @project
        response.should be_success
      end

      it "should have the right title" do
        get :show, :id => @project
        response.should have_selector("title", :content => @project.title)
      end
    end
  end

end
