class User < ApplicationRecord
    validates :name, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
    validates :salt, presence: true
    validates :password, presence: true

    after_save :clear_password

    def clear_password
        self.salt = nil
        self.password = nil
    end

    def authenticated(password)
        @saltCopy = self.salt
        @saltedPassword = BCrypt::Engine.hash_secret(password, @saltCopy)
        return self.password == @saltedPassword
    end
end
