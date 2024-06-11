class Api::V1::LearningResourcesController < ApplicationController
  def search
    resource = LearningResourceFacade.new(params[:country]).learning_resource_for_country

    render json: LearningResourceSerializer.new(resource)
  end
end
