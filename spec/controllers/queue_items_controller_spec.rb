require 'spec_helper'

describe QueueItemsController do
  describe "Get index" do
    it "should set @queue_items for logged user" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      queue_item1 = Fabricate(:queue_item, user: user, video: video)
      queue_item2 = Fabricate(:queue_item, user: user, video: video)
      get :index
      expect(assigns(:queue_items)).to include(queue_item1,queue_item2)
    end

    it "redirects to the sign in page for unauthenticated user" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "Post create" do
    it "redirects to the my queue page" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(response).to redirect_to my_queue_path
    end

    it "creates a queue item" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "creates an item that is associated with the video" do

      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end

    it "won't create a new duplicated item" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      QueueItem.create(order:1, video: video, user: user)
      post :create, video_id: video.id
      expect(QueueItem.count).to eq(1)
    end
  end

  describe "Delete destroy" do
    it "redirects to my_queue page" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      item = QueueItem.create(order: 1, video: video, user: user)
      delete :destroy, order: item.order, user_id: user.id
      expect(response).to redirect_to my_queue_path
    end

    it "delete the queue item" do
      user = Fabricate(:user)
      session[:user_id] = user.id
      video = Fabricate(:video)
      item = QueueItem.create(order: 1, video: video, user: user)
      delete :destroy, order: item.order, user_id: user.id
      expect(QueueItem.count).to eq(0)
    end

    it "does not deelte the queue item if it's not in the current user's queue" do
      jack = Fabricate(:user)
      wayne = Fabricate(:user)
      session[:user_id] = jack.id
      video = Fabricate(:video)
      item = QueueItem.create(order: 1, video: video, user: wayne)
      delete :destroy, order: item.order, user_id: wayne.id
      expect(QueueItem.count).to eq(1)
    end

    it "redirects to sign in page when user is not authenticated" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      item = QueueItem.create(order: 1, video: video, user: user)
      delete :destroy, order: item.order, user_id: user.id
      expect(response).to redirect_to sign_in_path
    end
  end
end
