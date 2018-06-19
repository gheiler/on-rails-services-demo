module Api
    module V1
        class UsersController < ApplicationController
            def index
                @users = User.order('created_at DESC').select('id, name, email, language, profileImage')
                render json: { data: @users }, status: :ok
            end
            def show
                @user = User.select('id, name, email, language, profileImage').find(params["id"])
                render json: { data: @user }, status: :ok
            end
            def create
                @user = User.new(user_params)
                @user.salt = BCrypt::Engine.generate_salt
                @user.password == BCrypt::Engine.hash_secret(@user.password, @user.salt)

                if @user.save
                    @user = User.select('id, name, email, language, profileImage').find_by(email: @user.email)
                    render json: { data: @user }, status: :ok
                else
                    puts @user.errors.full_messages
                    render json: { message: 'an error occured when trying to save the user', error: @user.errors.full_messages }, status: :unprocessable_entity
                end
            end
            def update
                @updateUser = User.new(user_params)
                @user = User.find(@updateUser.id)
                if @user.present?
                    if @user.authenticated(@updateUser.password)
                        @user.email = @updateUser.email
                        @user.name = @updateUser.name
                        @user.language = @updateUser.language
                        @user.profileImage = @updateUser.profileImage

                        if @user.save
                            @user = User.select('id, name, email, language, profileImage').find(@updateUser.id)
                            render json: { data: @user }, status: :ok and return
                        else
                            puts @user.errors.full_messages
                            render json: { message: 'an error occured when trying to save the user'}, 
                                status: :unprocessable_entity and return
                        end
                    end
                end
                render json: { message: 'email or password are incorrect' }, status: :unprocessable_entity
            end

            private

            def user_params
              params.require(:user).permit(:id, :name, :email, :password, :language, :profileImage)
            end
        end
    end
end
