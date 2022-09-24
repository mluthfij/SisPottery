class ApplicationController < ActionController::Base
    def after_sign_out_path_for(resource)
      root_path
    end

    def after_sign_in_path_for(resource)
      if current_user.admin?
        admin_pages_dashboard_path
      elsif !current_user.admin?
        products_path
      end
    end
end
