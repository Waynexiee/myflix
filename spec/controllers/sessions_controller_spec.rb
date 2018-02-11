require 'spec_helper'

describe SessionsController do
  describe "Get new" do
    context "with unaunthenticated user" do
      it "should render new template" do
        get :new
        expect(response).to render_template("new")
      end
    end

    context "with aunthenticated user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end

      it "should redirect to video page" do
        get :new
        expect(response).to redirect_to(videos_path)
      end
    end
  end

  describe "Post create" do
    context "sign in with valid user" do

      it "should redirect to videos page" do
        user = Fabricate(:user)
        post :create, session: {email: user.email, password: user.password}
        expect(response).to redirect_to(videos_path)
      end

      it "should set session" do
        user = Fabricate(:user)
        post :create, session: {email: user.email, password: user.password}
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "sign in with invalid user" do
      it "should render new template" do
        user = Fabricate(:user)
        post :create, session: {email: "fake@email.com", password: user.password}
        expect(response).to render_template("new")
      end

      it "should not set session" do
        user = Fabricate(:user)
        post :create, session: {email: "fake@email.com", password: user.password}
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "Delete destroy" do
    context "log out with logged user" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "should redirect to root path" do
        delete :destroy
        expect(response).to redirect_to(root_path)
      end

      it "should set session nil" do
        delete :destroy
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
