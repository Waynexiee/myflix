require 'spec_helper'

describe Admin::VideosController do
  describe "GET new" do
    it "redirects to sign_in page when not log in" do
      get :new
      expect(response).to redirect_to sign_in_path
    end

    it "sets the @video to a new video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end

    it "redirects the regular user to the sign in path" do
      set_current_user
      get :new
      expect(response).to redirect_to videos_path
    end

    it "flash error message for the regular user" do
      set_current_user
      get :new
      expect(flash[:error]).to be_present
    end
  end

  describe "POST create" do

    it "redirects to sign_in page when not log in" do
      post :create
      expect(response).to redirect_to sign_in_path
    end

    it "redirects the regular user to the sign in path" do
      set_current_user
      post :create
      expect(response).to redirect_to videos_path
    end

    context "with valid inputs" do
      it "redirect to the add new video page" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "monk", category_id: category.id, description: "good show!" }
        expect(response).to redirect_to new_admin_video_path
      end

      it "will create a video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "monk", category_id: category.id, description: "good show!" }
        expect(category.videos.count).to eq(1)
      end

      it "sets the flash success message" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { title: "monk", category_id: category.id, description: "good show!" }
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      it "doesn't create a video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        expect(category.videos.count).to eq(0)
      end

      it "will set @video" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        expect(assigns(:video)).to be_present
      end

      it "will render new template" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        expect(response).to render_template :new
      end

      it "sets the flash false message" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: { category_id: category.id, description: "good show!" }
        expect(flash[:error]).to be_present
      end
    end
  end
end