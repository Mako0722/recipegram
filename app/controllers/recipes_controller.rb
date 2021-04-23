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
    if @recipe.save 
      redirect_to recipe_path(@recipe), notice: '投稿に成功しました。'
    else
    render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    if @recipe.user != current_user
      redirect_to recipe_path, alert: '不正のアクセスです。'
    end
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
    # レシピに遷移する
     redirect_to recipe_path(@recipe), notice: '更新に成功しました。'
    else
      render :edit
    end
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
