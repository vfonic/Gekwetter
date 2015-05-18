require 'rails_helper'

describe MicropostsController, type: :controller do

  let(:valid_attributes) { attributes_for(:micropost) }

  let(:invalid_attributes) { attributes_for(:micropost, content: '') }

  context "when not signed in, block unauthenticated access" do
    before do
      @user = create(:user)
      sign_in nil
      allow(@user).to receive(:following)
      allow(Micropost).to receive(:timeline)
    end

    it "#timeline" do
      get :timeline
      expect(response).to redirect_to(new_user_session_path)
    end

    it "#create" do
      post :create, { user_id: @user.to_param, micropost: attributes_for(:micropost) }
      expect(response).to redirect_to(new_user_session_path)
    end

    it "#destroy" do
      delete :destroy, { user_id: @user.to_param, id: create(:micropost).to_param }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "authenticated user" do
    before do
      @user = create(:user)
      sign_in @user
      allow(@user).to receive(:following)
      @micropost = create(:micropost, user: @user)
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

        it "redirects to the user's profile" do
          create_micropost
          expect(response).to redirect_to(@user)
        end

        it "associates a newly created micropost to user" do
          create_micropost
          expect(assigns(:micropost).attributes.symbolize_keys[:user_id]).to eq(@user.id)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved micropost as @micropost" do
          request.env["HTTP_REFERER"] = '/'
          post :create, { user_id: @user.to_param, micropost: invalid_attributes }
          expect(assigns(:micropost)).to be_a_new(Micropost)
        end
      end
    end

    context "DELETE #destroy" do
      it "destroys the requested micropost" do
        expect { delete :destroy, { user_id: @user.to_param, id: @micropost.to_param } }.to change(Micropost, :count).by(-1)
      end

      it "redirects to the user's profile" do
        delete :destroy, { user_id: @user.to_param, id: @micropost.to_param }
        expect(response).to redirect_to(@user)
      end
    end
  end
end
