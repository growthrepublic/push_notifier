module API
  module V1
    class Users < Grape::API
      resource :users do
        params { requires :shared_id, type: Integer }
        namespace ':shared_id' do
          params { requires :message, type: String }
          post 'notify' do
            @user = User.by_shared_id(params[:shared_id]).first
            if @user
              @user.notifier.push(params[:message])
              present @user, with: API::V1::Entities::User
            else
              raise User::NotFoundError, "User not found"
            end
          end

          resource "devices" do
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
end
