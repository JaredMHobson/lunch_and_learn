class Api::V1::SessionsController < ApplicationController
  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        render json: UserSerializer.new(user)
      else
        render json: { errors: [{status: '400', title:'Email or password incorrect' }]},
        status: :bad_request
      end
    else
      render json: { errors: [{status: '400', title:'Email or password incorrect' }]},
      status: :bad_request
    end
  end
end
