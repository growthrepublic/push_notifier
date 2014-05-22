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

  describe "DELETE /users/:shared_id/devices" do
    context "not existing user" do
      let(:token) { "token" }

      it "does not find user" do
        delete "/api/v1/users/1/devices", { token: token }
        expect(response.status).to eq 404
      end
    end

    context "existing user" do
      let!(:user) { create(:user) }
      let!(:token) { user.devices.last }

      before(:each) do
        delete "/api/v1/users/#{user.shared_id}/devices", { token: token }
        user.reload
      end

      it "deregisters device" do
        expect(user.devices).to_not include token
      end

      it "returns existing user's entity" do
        expect(json).to be_representation_of(user)
          .with(user_presenter)
      end
    end
  end

  describe "POST /users/:shared_id/notify" do
    let(:message) { "message" }

    context "not existing user" do
      it "does not find user" do
        post "/api/v1/users/1/notify", { message: message }
        expect(response.status).to eq 404
      end
    end

    context "existing user" do
      subject { create(:user, :with_device) }

      before(:each) do
        @notifications = []
        expect(Notifier).to receive(:push) do |notification|
          @notifications.push(notification)
        end

        post "/api/v1/users/#{subject.shared_id}/notify", { message: message }
      end

      it "sends proper notification" do
        expect(@notifications).to_not be_empty
        expect(@notifications.last.device_token).to eq subject.devices.last
      end

      it "returns user's entity" do
        expect(json).to be_representation_of(User.last)
          .with(user_presenter)
      end
    end
  end
end
