class User < ApplicationRecord
    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minumum: 6, allow_nil: true}
    # validate :strong_password

    attr_reader :password

    # def strong_password
    #     if password.length >= 6 || password == allow_nil
    #         return true
    #     end
    #     return false
    # end

    #figvapber
    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(:password)
            user
        else
            nil
        end
    end

    def is_password
        if BCrypt::Password.new(self.password_digest).is_password?(password)
            return true
        end
        return false
end