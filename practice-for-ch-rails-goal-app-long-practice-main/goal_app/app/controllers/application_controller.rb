class ApplicationController < ActionController::Base
    helper_method :current_user
    
    #CHRLLL

    def current_user
        # if a current user already exists return it else find the user in the data base w the session token
        @current_user ||= User.find_by(session: session[:session_token])
    end

    def require_logged_in
        # if the user is not logged in redirect them to the log in page
        redirect_to new_session_url unless logged_in?
    end

    def require_logged_out
        # if the user is logged in redirect them to the users index
        redirect_to users_url if logged_in?
    end

    def logout!
        # if the current user is logged in reset their session token to log them out
        current_user.reset_session_token! if logged_in?
        # set the session token in the session object to nil
        session[:session_token] = nil
        # set the current user to nil
        @current_user = nil
    end

    def login(user)
        session[:session_token] = user.reset_session_token! 
        # if logged_out?
    end

    def logged_in?
        !!current_user
    end
end
