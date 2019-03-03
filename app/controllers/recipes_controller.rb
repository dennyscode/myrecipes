class RecipesController < ApplicationController
  before_action :set_recipe, only: [:edit, :show, :update]


  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def show
  end

  def update
    if @recipe.update(recipe_params)
      #handle this
      flash[:success] = "Recipe was updated succesfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = Chef.first
    if @recipe.save
      flash[:success] = "Recipe was created succesfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "Recipe deleted succesfully"
    redirect_to recipes_path
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name, :description)
    end


end
