include ActionView::Helpers::NumberHelper
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
      cost: params[:cost].present? ? number_with_precision(params[:cost], precision: 2) : params[:cost],
      country_code_of_origin: params[:country_code_of_origin].present? ? params[:country_code_of_origin].upcase : nil,
      province_code_of_origin: params[:province_code_of_origin].present? ? params[:province_code_of_origin].upcase : nil,
      sku: params[:sku],
      tracked: params[:tracked].nil? ? false : params[:tracked],
      requires_shipping: params[:requires_shipping].nil? ? false : params[:requires_shipping]
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
    @inventoryItem.cost = number_with_precision(params[:cost], precision: 2) if params[:cost].present?
    @inventoryItem.country_code_of_origin = params[:country_code_of_origin].upcase if params[:country_code_of_origin].present?
    @inventoryItem.province_code_of_origin = params[:province_code_of_origin].upcase if params[:province_code_of_origin].present?
    @inventoryItem.sku = params[:sku] if params[:sku].present?
    @inventoryItem.tracked = params[:tracked] if !tracked.nil?
    @inventoryItem.requires_shipping = params[:requires_shipping] if !requires_shipping.nil?

    if @inventoryItem.valid?
      @inventoryItem.save
      render json: @inventoryItem
    else
      render json: @inventoryItem.errors
    end
  end 

  def destroy
    @inventoryItem = InventoryItem.find(params[:id])
    @inventoryItem.destroy
    render json: @inventoryItem
  end
end
