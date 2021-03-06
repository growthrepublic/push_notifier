class User
  class NotFoundError < StandardError; end

  include Mongoid::Document
  include Mongoid::Timestamps

  field :shared_id, type: Integer
  field :devices, type: Array, default: []
  index({ shared_id: 1 }, { unique: true, background: true })

  scope :by_shared_id, ->(id) { where(shared_id: id) }

  validates :shared_id, presence: true

  def register_device(device)
    devices << device unless devices.include?(device)
    save
  end

  def deregister_device(device)
    devices.delete(device)
    save
  end

  def notifier
    UserNotifier.new(self)
  end

  def self.find_by_shared_id!(shared_id)
    user = by_shared_id(shared_id).first
    raise NotFoundError, "User not found" if user.blank?
    user
  end
end
