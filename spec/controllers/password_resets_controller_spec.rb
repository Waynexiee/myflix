require 'spec_helper'

describe PasswordResetsController do
  describe "Post create" do
    context "with blank input" do
      it "render new template" do
        post :create, email: ''
        expect(response).to render_template("new")
      end

      it "shows error message" do
        post :create, email: ''
        expect(flash[:error]).to eq("Email address not found")
      end
    end
    context "with existing email" do
      it 'redirect to password_reset_page' do
        user = Fabricate(:user)
        post :create, email: user.email
        expect(response).to redirect_to confirm_password_reset_path
      end

      it "sends out an email" do
        user = Fabricate(:user)
        post :create, email: user.email
        expect(ActionMailer::Base.deliveries.last.to).to eq([user.email])
      end
    end
    context "with non-existing email" do
      it "render new template" do
        post :create, email: "ajdfafds"
        expect(response).to render_template("new")
      end

      it "shows error message" do
        post :create, email: "das;fdsl"
        expect(flash[:error]).to eq("Email address not found")
      end
    end
  end
end
