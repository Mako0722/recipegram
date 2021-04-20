class RecipesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    # 誰が投稿しているかハッキリさせる
    @recipe.user_id = current_user.id
    # 保存する
    @recipe.save 
    redirect_to recipe_path(@recipe)
  end

  def edit
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end


end
