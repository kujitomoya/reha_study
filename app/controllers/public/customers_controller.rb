class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update, :favorites]

  def show
    @customer = Customer.find(params[:id])
    @customer_impressions = @customer.impressions
    @impressions = @customer.impressions.page(params[:page]).per(3)
    @favorites_count = 0
    @customer_impressions.each do |impression|
      @favorites_count += impression.favorites.count
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
       flash[:notice] = "更新に成功しました."
       redirect_to impressions_path
     else
       render :edit
     end
  end

  def unsubscribe
     @customer = Customer.find(params[:id])
  end

  def withdrawal
    @customer = current_customer
    @customer.update(is_deleted: true)
    sign_out current_customer
    redirect_to root_path
  end

  def favorites
    @customer = Customer.find(params[:id])
    favorites= Favorite.where(customer_id: @customer.id).pluck(:impression_id)
    @favorite_impressions = Impression.where(id: favorites).page(params[:page]).per(6)
  end

  private
  def customer_params
    params.require(:customer).permit(:name)
  end

  def is_matching_login_customer
    @customer = Customer.find(params[:id])
    customer_id = params[:id].to_i
    login_customer_id = current_customer.id
    if(customer_id != login_customer_id)
      redirect_to customer_path(current_customer.id)
    end
  end

end
