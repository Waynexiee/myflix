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

    it "nomalizes the remaining queue order" do
      jack = Fabricate(:user)
      wayne = Fabricate(:user)
      session[:user_id] = jack.id
      video = Fabricate(:video)
      item1 = QueueItem.create(order: 1, video: video, user: jack)
      item2 = QueueItem.create(order: 2, video: video, user: jack)
      delete :destroy, order: item1.order, user_id: jack.id
      expect(QueueItem.find(item2.id).order).to eq(1)
    end
  end

  describe "POST update_items" do
    context "with valid input" do
      it "should redirect to the my_queue page" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)

        post :update_queue, queue_items: [{id: item1.id, order: 2}, {id: item2.id, order: 1}]
        expect(response).to redirect_to my_queue_path
      end
      it "reorder the queue items" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)

        post :update_queue, queue_items: [{id: item1.id, order: 2}, {id: item2.id, order: 1}]
        expect(jack.queue_items).to eq([item2, item1])
      end
      it "nomalize the order numbers" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)

        post :update_queue, queue_items: [{id: item1.id, order: 5}, {id: item2.id, order: 2}]
        expect(jack.queue_items.map(&:order)).to eq([1, 2])
      end
    end

    context "with invalid input" do
      it "redirects to my_queue page" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 3.4}, {id: item2.id, order: 2}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets flash error message" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 3.4}, {id: item2.id, order: 2}]
        expect(flash[:error]).to be_present
      end

      it "doesn't change queue order" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 3.4}, {id: item2.id, order: 2}]
        expect(item1.reload.order).to eq(1)
      end
    end

    context "with unauthenticated user" do
      it "should redirect to the my_queue path" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: jack, order: 2, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 3}, {id: item2.id, order: 2}]
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with queue_items that doesn't belong to the current user" do
      it "should not change the queue item" do
        jack = Fabricate(:user)
        alice = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        item2 = Fabricate(:queue_item, user: alice, order: 2, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 3}, {id: item2.id, order: 2}]
        expect(item2.order).to eq(2)
      end
    end

    context "with valid selection for rating" do
      it "should change the rating if the review is present" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        review = Fabricate(:review, user: jack, video: video, score:2)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 1, score: 1}]
        expect(review.reload.score).to eq(1)
      end

      it "should clear the rating if the review is present" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        review = Fabricate(:review, user: jack, video: video, score:2)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 1, score: nil}]
        expect(review.reload.score).to be_nil
      end
      it "createss a rating if the review is absent" do
        jack = Fabricate(:user)
        video = Fabricate(:video)
        review = Fabricate(:review, user: jack, video: video, score:nil)
        session[:user_id] = jack.id
        item1 = Fabricate(:queue_item, user: jack, order: 1, video: video)
        post :update_queue, queue_items: [{id: item1.id, order: 1, score: 1}]
        expect(review.reload.score).to eq(1)
      end
    end
  end
end
