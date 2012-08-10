require 'spec_helper'

describe CommentsController do
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

end  
