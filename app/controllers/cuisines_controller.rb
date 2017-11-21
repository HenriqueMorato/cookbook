class CuisinesController < ApplicationController
  before_action :set_cuisine, only: %i[show]
  before_action :authenticate_user!, except: [:show]
  before_action :redirect_unless_admin, except: [:show]

  def show; end

  def new
    @cuisine = Cuisine.new
  end

  def create
    @cuisine = Cuisine.new(cuisine_params)
    if @cuisine.save
      redirect_to cuisine_path(@cuisine)
    else
      render :new
    end
  end

  private

  def set_cuisine
    @cuisine = Cuisine.find(params[:id])
  end

  def cuisine_params
    params.require(:cuisine).permit(:name)
  end

  def redirect_unless_admin
    unless current_user.admin?
      redirect_to root_path, alert: 'Acesso Negado, você 
                                     não possui permissão para 
                                     executar esta ação' 
    end  
  end
end
