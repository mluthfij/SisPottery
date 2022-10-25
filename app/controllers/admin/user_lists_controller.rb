module Admin
  class UserListsController < ApplicationController
    before_action :set_params, except: :index
    before_action :authenticate_user!
    before_action :restrict_user_by_role

        def index
            @users = User.all
        end

        def edit
        end
        
        def update
            if @user.update(user_params)
                redirect_to request.referrer, notice: "User was successfully deleted."
            else
                redirect_to request.referrer, notice: @user.errors.full_messages.to_sentence
            end
        end

        def destroy
            if @user.destroy
                redirect_to request.referrer, notice: "User was successfully deleted."
            else
                redirect_to request.referrer, notice: "User was failed to delete."
            end
        end

        private
        def set_params
            @user = User.find(params[:id])
        end

        def user_params
            params.require(:user).permit(:username, :password, :email)
        end
    
        protected
        # redirect if user not logged in or does not have a valid role
        def restrict_user_by_role
            redirect_to root_path, notice: "You're not authorized!" if current_user.admin == false
        end
    end
end