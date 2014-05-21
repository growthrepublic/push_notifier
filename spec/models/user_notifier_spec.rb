require "spec_helper"

describe UserNotifier do
  let(:user) { double(devices: %w(token-1)) }
  let(:message) { "message" }
  let(:custom)  { { whatever: true } }

  subject { described_class.new(user) }

  describe "#push" do
    let(:notification_builder) do
      ->(device) { { device_token: device } }
    end

    before(:each) do
      allow(Notifier).to receive(:push)
      expect(subject).to receive(:build_notification) do |opts|
        notification_builder.call(opts[:device])
      end
    end

    it "sends notification to each device" do
      subject.push(message, custom: custom)

      user.devices.each do |device|
        expect(Notifier).to have_received(:push)
          .with(notification_builder.call(device))
      end
    end
  end

  describe "#build_notification" do
    let(:device) { user.devices.sample }

    it "returns a grocer notification" do
      notification = subject.build_notification(
        device: device,
        message: message,
        custom: custom)

      expect(notification).to be_kind_of(Grocer::Notification)
      expect(notification.device_token).to eq device
      expect(notification.alert).to eq message
      expect(notification.custom).to eq custom
    end
  end
end
