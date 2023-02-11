class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update]

  def show
    @customer = Customer.find(params[:id])
    @impressions = @customer.impressions
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
       flash[:notice] = "You have updated user successfully."
       redirect_to customer_path(@customer.id)
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

  private

  def customer_params
    params.require(:customer).permit(:name)
  end

  def is_matching_login_customer
    customer_id = params[:id].to_i
    login_customer_id = current_customer.id
    if(customer_id != login_customer_id)
      redirect_to customer_path(current_customer.id)
    end
  end

end
