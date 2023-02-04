class Public::ImpressionsController < ApplicationController
  def index
    @impressions = Impression.all  
  end

  def new
    @impression = Impression.new
  end
  
  def create
    @impression = Impresion.new(impression_params)
    @impression.customer_id = current_customer.id
    @impression.save
    redirect_to impression_path
  end

  def show
  end

  def edit
  end
  
  def update
  end
  
   # 投稿データのストロングパラメータ
  private

  def impression_params
    params.require(:impression).permit(:name, :impression_title, :impression_text)
  end
end
