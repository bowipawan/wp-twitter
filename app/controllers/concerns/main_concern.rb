module MainConcern
  extend ActiveSupport::Concern
    def check_login
      if !session[:user_id]
        redirect_to main_path, alert: "Please login."
      end
    end

    def check_user
      if session[:user_id] != @user.id
        redirect_to user_path(@user.name), alert: "Access denied."
      end
    end

    def set_user_session
      @user = User.find(session[:user_id])
    end
end