class OutfitsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  
  def index
    @user = current_user
    @outfits = current_user.outfits.page(params[:page]).per(25)
  end

  def show
    @tops = Item.find_by(id: @outfit.tops)
    @outer = Item.find_by(id: @outfit.outer)
    @pants = Item.find_by(id: @outfit.pants)
    @bag = Item.find_by(id: @outfit.bag)
    @shoes = Item.find_by(id: @outfit.shoes)
  end

  def new
    @user = current_user
    @outfit = current_user.outfits.build
  end

  def create
    @user = current_user
    @outfit = current_user.outfits.build(outfit_params)
    if @outfit.save
      flash[:success] = 'コーディネートを登録しました。'
      redirect_to @outfit
    else
      @outfits = current_user.items.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'コーディネートの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @outfit.update(outfit_params)
      flash[:success] = 'コーディネートを更新しました。'
      redirect_to @outfit
    else
      flash.now[:danger] = 'コーディネートは更新されませんでした。'
    end
  end

  def destroy
    @outfit.destroy
    flash[:success] = 'コーディネートを削除しました'
    redirect_to outfits_url
  end
  
  private
  
  def outfit_params
    params.require(:outfit).permit(:title, :concept, :tops, :outer, :pants, :bag, :shoes)
  end
  
  def correct_user
    @user = current_user
    @outfit = current_user.outfits.find_by(id: params[:id])
    unless @outfit
      redirect_to root_url
    end
  end
  
end