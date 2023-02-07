class Public::ImpressionsController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]
  
  def index
    @impressions = Impression.all  
  end

  def new
    @impression = Impression.new
  end
  
  def create
    @impression = Impression.new(impression_params)
    @impression.customer_id = current_customer.id
    #binding.pry
    @impression.save
    redirect_to impressions_path
  end

  def show
    @impression = Impression.find(params[:id])  
  end

  def edit
    @impression = Impression.find(params[:id])
  end
  
  def update
    impression = Impression.find(params[:id])
    impression.update(impression_params)
    redirect_to impression_path(impression.id)  
  end
  
  def destroy
    impression = Impression.find(params[:id])
    impression.destroy
    redirect_to impressions_path
  end

  private

  def impression_params
    params.require(:impression).permit(:name, :impression_title, :impression_text)
  end
  
  def is_matching_login_customer
    @impressions = Impression.find(params[:id])
    customer_id = @impressions.customer.id
    login_customer_id = current_customer.id
    if(customer_id != login_customer_id)
      redirect_to impressions_path
    end
  end 
  
end
