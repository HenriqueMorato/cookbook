class CuisinesController < ApplicationController
  before_action :set_cuisine, only: %i[show]
  def show; end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end
end
