module API
  module V1
    module Entities
      class User < Grape::Entity
        expose :shared_id
        expose :devices
      end
    end
  end
end
