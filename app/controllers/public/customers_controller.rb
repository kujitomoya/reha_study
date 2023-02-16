class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update, :favorites]

  def show
    @customer = Customer.find(params[:id])
    @impressions = @customer.impressions.page(params[:page]).per(10)
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
    @favorite_impressions = Impression.find(favorites)
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
