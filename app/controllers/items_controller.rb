class ItemsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @items = current_user.items
  end

  def show
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = 'アイテムを登録しました。'
      redirect_to @item
    else
      @items = current_user.items.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'アイテムの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:success] = 'アイテムは正常に更新されました'
      redirect_to @item
    else
      flash.now[:danger] = 'アイテムは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @item.destroy
    flash[:success] = 'アイテムを削除しました'
    redirect_to items_url
  end
  
  private
  
  def item_params
    params.require(:item).permit(:item_name, :category, :brand, :color, :size, :purchase_price, :remarks)
  end
  
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
end
