require "spec_helper"

describe Notifier do
  describe "pushers" do
    let(:namespace) { "development" }
    let(:notification) { "notification" }
    let(:pushers) do
      2.times.map { double("pusher", push: nil) }
    end

    before(:each) do
      pushers.each do |pusher|
        described_class.register_pusher(pusher, namespace)
      end
    end

    it "uses registered pushers to push notification" do
      described_class.push(notification, namespace)

      pushers.each do |pusher|
        expect(pusher).to have_received(:push)
          .with(notification)
      end
    end
  end
end
