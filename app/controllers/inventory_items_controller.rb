class InventoryItemsController < ApplicationController
  def index
    @inventoryItems = InventoryItem.all
    render json: @inventoryItems
  end

  def show
    @inventoryItem = InventoryItem.find(params[:id])
    render json: @inventoryItem
  end 

  def create
    @inventoryItem = InventoryItem.new(
      cost: params[:cost],
      country_code_of_origin: params[:country_code_of_origin],
      province_code_of_origin: params[:province_code_of_origin],
      sku: params[:sku],
      tracked: params[:tracked],
      requires_shipping: params[:requires_shipping]
    )
    if @inventoryItem.valid?
      @inventoryItem.save
      render json: @inventoryItem
    else
      render json: @inventoryItem.errors
    end
  end 

  def update
    @inventoryItem = InventoryItem.find(params[:id])
    @inventoryItem.update(
      cost: params[:cost],
      country_code_of_origin: params[:country_code_of_origin],
      province_code_of_origin: params[:province_code_of_origin],
      sku: params[:sku],
      tracked: params[:tracked],
      requires_shipping: params[:requires_shipping]
    )
    render json: @inventoryItem
  end 

  def destroy
    @inventoryItem = InventoryItem.find(params[:id])
    @inventoryItem.destroy
    render json: @inventoryItem
  end 
end
