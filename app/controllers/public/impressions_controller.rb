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
    if @impression.save
      flash[:notice] = "投稿に成功しました！"
      redirect_to impressions_path
    else
      render :new
    end
  end

  def show
    @impression = Impression.find(params[:id])
  end

  def edit
    @impression = Impression.find(params[:id])
  end

  def update
    @impression = Impression.find(params[:id])
    if @impression.update(impression_params)
      flash[:notice] = "編集に成功しました！"
      redirect_to impression_path(@impression)
    else
      render :edit
    end
  end   
    
  def destroy
    impression = Impression.find(params[:id])
    impression.destroy
    redirect_to impressions_path
  end

  private

  def impression_params
    params.require(:impression).permit(:name, :title, :text, :field_id)
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