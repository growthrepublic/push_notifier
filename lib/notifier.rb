module Notifier
  mattr_accessor :pushers
  self.pushers = Hash.new { |hash, key| hash[key] = [] }

  class << self
    def register_pusher(pusher, env = Rails.env)
      pushers[env] << pusher
    end

    def push(notification, env = Rails.env)
      pushers[env].each do |pusher|
        pusher.push(notification)
      end
    end
  end
end
