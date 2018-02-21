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
      let(:charge) { double(:charge, successful?: true) }
      before do
        StripeWrapper::Charge.stub(:create).and_return(charge)
      end

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

    context "sending emails" do
      let(:charge) { double(:charge, successful?: true) }
      before do
        StripeWrapper::Charge.stub(:create).and_return(charge)
      end
      after { ActionMailer::Base.deliveries.clear }
      it "sends out email to user with valid inputs" do
        post :create, user: { email: "aa@1.com", name:"Jack", password: "123456" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(["aa@1.com"])
      end

      it "sends out email containing the user's name with valid input" do
        post :create, user: { email: "aa@1.com", name:"Jack", password: "123456" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Jack")
      end

      it "doesn't send out email with invalid inputs" do
        post :create, user: { email: "", name:"Jack", password: "123456" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe "Get show" do
    it "sets @user" do
      user = Fabricate(:user)
      session[:user_id] = Fabricate(:user).id
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end
