class RecipesController < ApplicationController
  # ログインしてないと見れないようにするために↓の記述をしているexcept: [index]を入れてここはログインなしでも見れるようにしている
  before_action :authenticate_user!, except: [:index]


  def index
    @recipes =Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    @recipe.update(recipe_params)
    # レシピに遷移する
    redirect_to recipe_path(@recipe)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to recipe_path
  end

  private
  def recipe_params
    params.require(:recipe).permit(:title, :body, :image)
  end

end
