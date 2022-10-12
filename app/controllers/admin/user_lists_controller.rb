module Admin
  class UserListsController < ApplicationController
    before_action :set_params, except: :index
        def index
            @users = User.all
        end

        def edit
        end
        
        def update
            respond_to do |format|
                if @user.update(user_params)
                    format.html { redirect_to admin_user_lists_url, notice: "User was successfully updated." }
                else
                    format.html { render :edit, status: :unprocessable_entity }
                end
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
    end
end