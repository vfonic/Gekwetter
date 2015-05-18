require 'rails_helper'

describe UsersController, type: :controller do

  let(:valid_attributes) { attributes_for(:user) }

  let(:invalid_attributes) { attributes_for(:user, content: '') }

  before { @user = create(:user) }

  shared_examples_for "assigned requested user" do |action|
    it "assigns the requested user as @user" do
      get action, { id: requested_user.to_param }
      expect(assigns(:user)).to eq(requested_user)
    end
  end

  shared_examples_for "following users" do |action|
    it "when authenticated it assigns users that current_user is following as @following" do
      sign_in user
      user_to_follow = create(:user)
      expect(user).to receive(:following).and_return([user_to_follow])
      get action, { id: user.to_param }
      expect(assigns(:following)).to eq([user_to_follow])
    end
  end

  context "GET #index" do
    it_behaves_like "following users", :index do
      let(:user) { @user }
    end

    it "assigns all users as @users" do
      get :index
      expect(assigns(:users)).to eq([@user])
    end
  end

  context "GET #show" do
    it_behaves_like "assigned requested user", :show do
      let(:requested_user) { @user }
    end

    it "assigns user's microposts as @microposts" do
      micropost = create(:micropost, user: @user)
      get :show, { id: @user.to_param }
      expect(assigns(:microposts)).to eq([micropost])
    end
  end

  require 'pry-remote'
  shared_examples_for "follow" do |action|
    it_behaves_like "following users", action do
      let(:user) { @user }
    end

    it_behaves_like "assigned requested user", action do
      let(:requested_user) { @user }
    end

    def get_follow_action(action)
      get action, { id: @user.to_param }
    end

    it "assigns user's following/followers as @users" do
      user_to_follow = create(:user)
      @user.follow! user_to_follow if action == :following
      user_to_follow.follow! @user if action == :followers
      get action, { id: @user.to_param }
      expect(assigns(:users)).to eq([user_to_follow])
    end

    it "assigns follow type" do
      get_follow_action(action)
      expect(assigns(:follow_type)).to eq(action.to_s)
    end

    it "renders follow" do
      get_follow_action(action)
      expect(response).to render_template :follow
    end
  end

  context "GET #following" do
    it_behaves_like "follow", :following
  end

  context "GET #followers" do
    it_behaves_like "follow", :followers
  end
end
