class Api::V1::FavoritesController < ApplicationController
  def index
    if user = User.find_by(api_key: params[:api_key])
      favorites = user.favorites
      render json: FavoriteSerializer.new(favorites)
    else
      render json: { errors: [{status: '404', title:'No user found with that API key' }]},
        status: :not_found
    end
  end

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
