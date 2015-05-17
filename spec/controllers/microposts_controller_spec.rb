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

  context "authenticated user" do
    before do
      @user = create(:user)
      sign_in @user
      @user.stub(:following)
      @micropost = create(:micropost)
      allow(Micropost).to receive(:timeline).and_return([@micropost])
    end

    context "GET #timeline" do
      it "assigns all microposts as @microposts" do
        get :timeline
        expect(assigns(:microposts)).to eq([@micropost])
      end
    end

    context "POST #create" do
      context "with valid params" do
        def create_micropost
          post :create, { user_id: @user.to_param, micropost: valid_attributes }
        end

        it "creates a new Micropost" do
          expect { create_micropost }
            .to(change(Micropost, :count).by(1))
        end

        it "assigns a newly created micropost as @micropost" do
          create_micropost
          expect(assigns(:micropost)).to be_a(Micropost)
          expect(assigns(:micropost)).to be_persisted
        end

        it "redirects to the users_profile micropost" do
          create_micropost
          expect(response).to redirect_to(@user)
        end

        it "associates a newly created micropost to user" do
          create_micropost
          expect(assigns(:micropost).attributes.symbolize_keys[:user_id]).to eq(@user.id)
        end
      end
    end
  end
end
