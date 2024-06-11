class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.email = user.email.downcase
    user.save!
    render json: UserSerializer.new(user), status: :created
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
