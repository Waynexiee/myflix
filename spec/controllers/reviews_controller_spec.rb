require 'spec_helper'

describe ReviewsController do
  describe "Post create" do
    describe "with authenticated user" do
      let(:user) { Fabricate(:user) }
      before do
        session[:user_id] = user.id
      end
      context "with valid input" do
        it "redirects to video page" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(response).to redirect_to video
        end

        it "creates new @review" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(video.reviews.count).to eq(1)
        end

        it "creates a review associated with the video" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(video.reviews.first.video_id).to eq(video.id)
        end

        it "creates a review associated with the user" do
          video = Fabricate(:video)
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
          expect(video.reviews.first.user_id).to eq(session[:user_id])
        end
      end

      context "with invlid input" do
        it "doesn't create a review" do
          video = Fabricate(:video)
          post :create, review: {score:"5 Stars"}, video_id: video.id
          expect(video.reviews.count).to eq(0)
        end

        it "renders the show template" do
          video = Fabricate(:video)
          post :create, review: {score:"5 Stars"}, video_id: video.id
          expect(response).to render_template('videos/show')
        end

      end
    end

    describe "with unauthenticated user" do
      it "should redirect to sign in path" do
        video = Fabricate(:video)
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
