require 'rails_helper'

describe MicropostsController, type: :controller do

  let(:valid_attributes) { attributes_for(:micropost) }

  let(:invalid_attributes) { }

  context "when not signed in, block unauthenticated access" do
    before do
      @user = create(:user)
      sign_in nil
      @user.stub(:following)
      allow(Micropost).to receive(:timeline)
    end

    it "#timeline" do
      get :timeline
      response.should redirect_to(new_user_session_path)
    end

    it "#create" do
      post :create, { user_id: @user.to_param, micropost: attributes_for(:micropost) }
      response.should redirect_to(new_user_session_path)
    end

    it "#destroy" do
      delete :destroy, { user_id: @user.to_param, id: create(:micropost).to_param }
      response.should redirect_to(new_user_session_path)
    end
  end
end
