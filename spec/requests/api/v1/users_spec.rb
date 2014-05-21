require 'spec_helper'

describe API::V1::Users, type: :request do
  let(:user_presenter) { API::V1::Entities::User }

  describe "POST /users/:shared_id/devices" do
    let(:token) { "token" }
    let(:shared_id) { 1 }

    context "not existing user" do
      before(:each) do
        post "/api/v1/users/#{shared_id}/devices", { token: token }
      end

      it "creates user with device" do
        created_user = User.last
        expect(created_user.shared_id).to eq shared_id
        expect(created_user.devices).to include token
      end

      it "returns user's entity" do
        expect(json).to be_representation_of(User.last)
          .with(user_presenter)
      end
    end

    context "existing user" do
      let!(:user) { create(:user) }

      before(:each) do
        post "/api/v1/users/#{user.shared_id}/devices", { token: token }
        user.reload
      end

      it "registers device" do
        expect(user.shared_id).to eq shared_id
        expect(user.devices).to include token
      end

      it "returns existing user's entity" do
        expect(json).to be_representation_of(user)
          .with(user_presenter)
      end
    end
  end
end
