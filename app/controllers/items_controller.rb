class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create]
  
  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    
    if @item.save
      redirect_to items_path, notice: 'Item was successfully created.'
    else
      flash.now[:alert] = 'Failed to create item. Please check your input.'
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
    @category_name = @item.category.name
  end
  
  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
    @conditions = Condition.all
    @shipping_costs = ShippingCost.all
    @prefectures = Prefecture.all
    @shipping_durations = ShippingDuration.all
  end


  private

  def item_params
    params.require(:item).permit(:title, :description, :category_id, :condition_id, :shipping_cost_id, :prefecture_id, :shipping_duration_id, :price, :image)
  end  
end
