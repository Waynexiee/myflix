require 'spec_helper'

describe UsersController do
  describe "Get new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "Post create" do
    context "with valid params" do
      it "creates new @user" do
        post :create, user: {email: "a@1.com", name: "Suck", password: "password"}
        expect(User.count).to eq(1)
      end

      it "should redirect to sign_in path" do
        post :create, user: {email: "a@1.com", name: "Suck", password: "password"}
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "with invalid params" do

      it "doesn't create new user" do
        post :create, user: {email: "", name: "Suck", password: "password"}
        expect(User.count).to eq(0)
      end
      it "should render new template" do
        post :create, user: {email: "", name: "Suck", password: "password"}
        expect(response).to render_template("new")
      end

      it "should set @user" do
        post :create, user: {email: "", name: "Suck", password: "password"}
        expect(assigns(:user)).to be_instance_of(User)
      end
    end


  end
end
