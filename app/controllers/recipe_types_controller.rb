class RecipeTypesController < ApplicationController
  before_action :set_recipe_type, only: %i[show]
  before_action :authenticate_user!, except: %i[show]
  before_action :redirect_unless_admin, except: [:show]

  def show; end

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(recipe_type_params)

    if @recipe_type.save
      redirect_to recipe_type_path(@recipe_type)
    else
      render :new
    end
  end

  private

  def set_recipe_type
    @recipe_type = RecipeType.find(params[:id])
  end

  def recipe_type_params
    params.require(:recipe_type).permit(:name)
  end

  def redirect_unless_admin
    return if current_user.admin?
    redirect_to root_path, alert: 'Acesso Negado, você '\
                                  'não possui permissão para '\
                                  'executar esta ação'
  end
end
