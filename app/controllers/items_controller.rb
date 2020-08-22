class ItemsController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  def index
    @user = current_user
    @items = current_user.items.order(sort_column + ' ' + sort_direction).page(params[:page]).per(25)
  end

  def show
  end

  def new
    @user = current_user
    @item = current_user.items.build
    @bag_count = current_user.items.where(category: 4).count
    # 制限数チェック(警告)
    flash.now[:warning] = '制限数に達しているアイテムは登録できません' if max_tops? || max_outer? || max_pants? || max_bag? || max_shoes?
  end

  def create
    @user = current_user
    @item = current_user.items.build(item_params)
    @new_item = params[:item][:category]
 
    # 制限数を超えて登録しようとした時に登録させない　ここから
    if max_tops? && (@new_item == "tops")
      flash.now[:danger] = 'トップスがいっぱいなので登録できません'
      render :new and return
    elsif max_outer? && (@new_item == "outer")
      flash.now[:danger] = 'アウター/ジャケットがいっぱいなので登録できません'
      render :new and return
    elsif max_pants? && (@new_item == "pants")
      flash.now[:danger] = 'パンツがいっぱいなので登録できません'
      render :new and return
    elsif max_bag? && (@new_item == "bag")
      flash.now[:danger] = 'バッグがいっぱいなので登録できません'
      render :new and return
    elsif max_shoes? && (@new_item == "shoes")
      flash.now[:danger] = 'シューズがいっぱいなので登録できません'
    end
    # 制限数を超えて登録しようとした時に登録させない　ここまで
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
      flash[:success] = 'アイテムを更新しました'
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
    @user = current_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end
  
  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
  
  # 制限数を超えているかの確認用メソッド
  def max_tops?
    if current_user.max_tops
      if  current_user.items.where(category: 'tops').count >= current_user.max_tops
        return true
      else
        return false
      end
    end
  end
  
  def max_outer?
    if current_user.max_outer
      if current_user.items.where(category: 'outer').count >= current_user.max_outer
        return true
      else
        return false
      end
    end
  end
  
  
  def max_pants?
    if current_user.max_pants
      if current_user.items.where(category: 'pants').count >= current_user.max_pants
        return true
      else
        return false
      end
    end
  end
  
  
  def max_bag?
    if current_user.max_bag
      if current_user.items.where(category: 'bag').count >= current_user.max_bag
        return true
      else
        return false
      end
    end
  end
  
  def max_shoes?
    if current_user.max_shoes
      if current_user.items.where(category: 'shoes').count >= current_user.max_shoes
        return true
      else
        return false
      end
    end
  end
  
end