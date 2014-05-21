require 'spec_helper'

describe User, :type => :model do
  describe "factories" do
    context "default" do
      subject { create(:user) }
      it { should be_valid }
    end

    context "with device" do
      subject { create(:user, :with_device) }
      it { should be_valid }
      its(:devices) { should_not be_empty }
    end
  end

  describe "#register_device" do
    context "unique" do
      let(:device) { "first-device" }

      subject { create(:user) }

      it "adds device to devices" do
        subject.register_device(device)
        expect(subject.reload.devices).to include(device)
      end
    end

    context "the same again" do
      subject { create(:user, :with_device) }

      it "does not duplicate device" do
        subject.register_device(subject.devices.sample)
        expect(subject.reload.devices.count).to eq 1
      end
    end
  end

  describe "#deregister_device" do
    context "existing device" do
      subject { create(:user, :with_device) }

      it "removes device" do
        subject.deregister_device(subject.devices.sample)
        expect(subject.reload.devices).to be_empty
      end
    end

    context "not existing device" do
      let(:missing_device) { "invalid-device" }
      subject { create(:user, :with_device) }

      it "does not complain" do
        existing_devices = subject.devices
        subject.deregister_device(missing_device)
        expect(subject.reload.devices).to match_array(existing_devices)
      end
    end
  end
end
