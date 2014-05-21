class UserNotifier < Struct.new(:user)
  def push(message, custom: {})
    user.devices.each do |device|
      notification = build_notification(
        device: device,
        message: message,
        custom: custom)

      Notifier.push(notification)
    end
  end

  def build_notification(device: device, message: "", custom: {})
    Grocer::Notification.new(
      device_token: device,
      alert: message,
      badge: 1,
      custom: custom)
  end
end
