module Api
    module V1
        class AuthController < ApplicationController
            def create
                @email = params['email']
                @password = params['password']

                @user = User.find_by(email: @email)

                @saltedPassword = BCrypt::Engine.hash_secret(@password, @user.salt)

                if @user.authenticated(@password)
                    # ideally we should add authorization token
                    render json: { data: 'logged in!' }, ok: :ok
                else
                    render json: { data: 'email or password are incorrect' }, ok: :bad_request
                end
            end
        end
    end
end