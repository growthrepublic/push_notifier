module API
  module V1
    class Users < Grape::API
      resource :users do
        params { requires :shared_id, type: Integer }

        resource ":shared_id/devices" do
          params { requires :token, type: String }

          post do
            @user = User.by_shared_id(params[:shared_id]).first_or_create!
            @user.register_device(params[:token])
            present @user, with: API::V1::Entities::User
          end
        end
      end
    end
  end
end
