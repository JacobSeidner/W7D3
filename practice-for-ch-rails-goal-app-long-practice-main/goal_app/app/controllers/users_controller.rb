class UsersController < User
    def index
        @users = User.all
        render :index
    end

    # def new

    # end
end