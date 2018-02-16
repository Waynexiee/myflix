require 'spec_helper'

describe FriendshipsController do
  describe "Get index" do
    it "should set @followings" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      user2 = Fabricate(:user)
      friendship = Friendship.create(user: user, friend: user2)
      get :index
      expect(assigns(:followings)).to eq([friendship])
    end

    it "redirect to sign_in_path if not sign_in" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "Delete destroy" do

    it "should redirect to sign in path if not log in" do
      delete :destroy, id: 1
      expect(response).to redirect_to sign_in_path
    end

    it "should destroy the friendship if the follower is current user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      user2 = Fabricate(:user)
      friendship = Friendship.create(user: user, friend: user2)
      delete :destroy, id: friendship.id
      expect(Friendship.count).to eq(0)
    end

    it "should redirect to people path" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      user2 = Fabricate(:user)
      friendship = Friendship.create(user: user, friend: user2)
      delete :destroy, id: friendship.id
      expect(response).to redirect_to people_path
    end

    it "should not destroy friendship if follower is not current user" do
      user = Fabricate(:user)
      session[:user_id] = Fabricate(:user).id
      user2 = Fabricate(:user)
      friendship = Friendship.create(user: user, friend: user2)
      delete :destroy, id: friendship.id
      expect(Friendship.count).to eq(1)
    end
  end

  describe "POST create" do
    it "shuold create a new friendship when log in" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      user2 = Fabricate(:user)
      post :create, friend_id: user2.id
      expect(user.friendships.count).to eq(1)
    end

    it "shuold redirect to sign in path for unlogged user" do
      user2 = Fabricate(:user)
      post :create, friend_id: user2.id
      expect(response).to redirect_to sign_in_path
    end

    it "shuold not follow the same guy twice" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      user2 = Fabricate(:user)
      Friendship.create(user:user, friend:user2)
      post :create, friend_id: user2.id
      expect(user.friendships.count).to eq(1)
    end

    it "should not follow himself" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, friend_id: user.id
      expect(user.friendships.count).to eq(0)
    end
  end

end
