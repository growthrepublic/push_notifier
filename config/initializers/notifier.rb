require "notifier"

cert_path       = Rails.root + "config/certificates/#{Rails.env}.pem"
cert_dev_path   = Rails.root + "config/certificates/#{Rails.env}.dev.pem"
cert_passphrase = Rails.application.secrets.certificate_passphrase

if Rails.env.production?
  pusher = Grocer.pusher(
    certificate: cert_path,
    passphrase:  cert_passphrase,
    gateway:     "gateway.push.apple.com")

  Notifier.register_pusher(pusher, env)
end

if Rails.env.development?
  dev_pusher = Grocer.pusher(
    certificate: cert_dev_path,
    passphrase:  cert_passphrase,
    gateway:     "gateway.sandbox.push.apple.com")

  Notifier.register_pusher(dev_pusher, env)
end
