require 'spec_helper'

describe VideosController do
  describe "Get show" do
    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "sets the @video" do
        video1 = Fabricate(:video)
        get :show, id: video1.id
        expect(assigns(:video)).to eq(video1)
      end

      it "should set the @reviews for videos" do
        video1 = Fabricate(:video)
        user = Fabricate(:user)
        review1 = Fabricate(:review, video:video1, user:user)
        review2 = Fabricate(:review, video:video1, user:user)
        get :show, id: video1.id
        expect(assigns(:reviews)).to include(review1,review2)
      end

      it "renders the show template" do
        video1 = Fabricate(:video)
        get :show, id: video1.id
        expect(response).to render_template("show")
      end
    end

    context "with unauthenticated user" do
      it "redirects to sign_in page" do
        video1 = Fabricate(:video)
        get :show, id: video1.id
        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe "Get search" do
    context "with authenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "sets @videos" do
        video1 = Fabricate(:video, title: "fuck")
        get :search, search: "u"
        expect(assigns(:videos)).to eq([video1])
      end
    end

    context "with unauthenticated user" do
      it "sets @videos" do
        video1 = Fabricate(:video, title: "fuck")
        get :search, search: "u"
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
