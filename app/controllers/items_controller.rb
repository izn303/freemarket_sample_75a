class ItemsController < ApplicationController
  before_action :set_item, only: [:destory, :show, :edit]

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
      flash[:alert] = '出品できませんでした'
      render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def show
  end

  def destory
    @item.destory
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :brand, :item_status_id, :shipment_fee_id, :shipment_pref_id, :shipment_date_id, :price, images_attributes: [:url, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end


end
