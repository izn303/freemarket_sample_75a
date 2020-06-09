class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]

  def index
    @items = Item.includes(:images)
  end

  def new
    if user_signed_in?
    @category = Category.all.order("ancestry,id").limit(13)
    @item = Item.new
    @item.images.new
    else
      redirect_to new_user_session_path
    end
  end

  def category_children
    @category_children = Category.find(params[:productcategory]).children 
  end
    
  def category_grandchildren
    @category_grandchildren = Category.find(params[:productcategory]).children
  end

  def create
    @category = Category.all.order("ancestry,id").limit(13)
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = '出品できました'
      redirect_to root_path
    else
      render action: "new"
      flash[:alert] = '出品できませんでした'
    end
  end

  def edit
    if user_signed_in? && current_user.id == @item.seller_id
      @category = Category.all.order("ancestry,id").limit(13)
      @category_parent_array = Category.where(ancestry: nil)
      @category_child_array = @item.category.parent.parent.children
      @category_grandchild_array = @item.category.parent.children
    else
      redirect_to action: "show"
      flash[:alert] = '編集する権限がありません'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: '編集完了しました'
    else
      redirect_to action: "edit"
      flash[:alert] = '編集できませんでした'
    end
  end
  
  def show
    @category = Category.all.order("ancestry,id").limit(13)
  end  

  def destroy

    if @item.destroy
      redirect_to root_path, notice: '削除が完了しました'
    else
      redirect_to root_path, alert: '削除できませんでした'
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :brand, :item_status_id, :shipment_fee_id, :shipment_pref_id, :shipment_date_id, :price, images_attributes: [:url, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
