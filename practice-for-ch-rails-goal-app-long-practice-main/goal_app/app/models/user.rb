class User < ApplicationRecord
    before_validation :ensure_session_token

    validates :username, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6, allow_nil: true}

    attr_reader :password

#FIGVAPEBR

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        # find the user by username
        if user && user.is_password?(password)
            # if the user is not nil && the password is correct return user else return nil
            user
        else
            nil
        end
    end

    def is_password?(password)
        # this is reading the password digest in BCrypt
        password_object = BCrypt::Password.new(self.password_digest)
        # checking if the password digest is the expected result of salting & hashing the password
        password_object.is_password?(password)
    end

    def generate_session_token
        SecureRandom::urlsafe_base64
    end

    def password=(password)
        # storing the password in an instance variable 
        @password = password
        # store the hashed password in the password digest
        self.password_digest = BCrypt::Password.create(password)
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

end