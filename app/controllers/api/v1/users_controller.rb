class Api::V1::UsersController < ApplicationController
  skip_before_action :doorkeeper_authorize!, only: %i[create], raise: false

  def create
    role = Role.find_by(code: 'USR')
    user = User.new(email: user_params[:email], password: user_params[:password], name: user_params[:name],
                    surname: user_params[:surname], login: user_params[:login], birthday: user_params[:birthday],
                    role: role)

    client_app = Doorkeeper::Application.find_by(uid: params[:client_id])

    return render(json: { error_message: 'Invalid client ID', error_code: 403 }, status: 403) unless client_app

    if user.save
      # create access token for the user
      access_token = Doorkeeper::AccessToken.create(
        resource_owner_id: user.id,
        application_id: client_app.id,
        refresh_token: generate_refresh_token,
        expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
        scopes: ''
      )

      # return json containing access token and refresh token
      # so that user won't need to call login API right after registration
      render(json: {
        access_token: access_token.token,
        token_type: 'bearer',
        expires_in: access_token.expires_in,
        refresh_token: access_token.refresh_token,
        created_at: access_token.created_at.to_time.to_i
      })
    else
      render(json: { error_message: user.errors.full_messages, error_code: 422 }, status: 422)
    end
  end

  def current_user
    @user = User.find(doorkeeper_token.resource_owner_id) rescue nil

    if @user
      render json: @user
    else
      render(json: { error_message: 'User not authorized', error_code: 403 }, status: 403)
    end
  end

  def change_password
    @user = User.find(doorkeeper_token.resource_owner_id) rescue nil
    if params[:old_password]
      if @user.valid_password?(params[:old_password])
        if params[:new_password]
          @user.update!(password: params[:new_password])
          render json: { success: true }
        else
          render(json: { error_message: 'New password was not provided!', error_code: 400 }, status: 400)
        end
      else
        render(json: { error_message: 'Bad old password', error_code: 403 }, status: 403)
      end
    else
      render(json: { error_message: 'Old password was not provided!', error_code: 400 }, status: 400)
    end
  end

  private

  def user_params
    params.permit(:email, :password, :name, :surname, :login, :birthday, :image_url)
  end

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end
end

