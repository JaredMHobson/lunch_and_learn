class Api::V1::FavoritesController < ApplicationController
  def create
    if user = User.find_by(api_key: params[:api_key])
      if user.favorites.create!(favorite_params)
        render json: { success: 'Favorite added successfully' },
          status: :created
      end
    else
      render json: { errors: [{status: '404', title:'No user found with that API key' }]},
        status: :not_found
    end
  end

  private
  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end
