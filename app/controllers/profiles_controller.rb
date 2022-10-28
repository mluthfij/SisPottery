class ProfilesController < ApplicationController
  def show
    @profile = User.find(params[:id])
  end

  def purge_avatar
    @profile = User.find(params[:id])
    @profile.avatar.purge
    redirect_back fallback_location: root_path, notice: "success"
  end
        
  def upload_avatar
      @profile = User.find(params[:id])
      if @profile.update(params.permit(:avatar))
          redirect_to request.referrer, notice: "Avatar was successfully updated."
      else
          redirect_to request.referrer, notice: @profile.errors.full_messages.to_sentence
      end
  end
end
