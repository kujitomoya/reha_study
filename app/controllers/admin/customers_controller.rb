class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(6)
  end

  def show
    @customer = Customer.find(params[:id])
    @customer_impressions = @customer.impressions
    @impressions = @customer.impressions.page(params[:page]).per(4)
    @favorites_count = 0
    @customer_impressions.each do |impression|
      @favorites_count += impression.favorites.count
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    redirect_to admin_customers_path
  end
end
