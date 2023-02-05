class Public::ImpressionsController < ApplicationController
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
    impression = Impression.find(params[:id])  # データ（レコード）を1件取得
    impression.destroy  # データ（レコード）を削除
    redirect_to impressions_path  # 投稿一覧画面へリダイレクト  
  end
  
   # 投稿データのストロングパラメータ
  private

  def impression_params
    params.require(:impression).permit(:name, :impression_title, :impression_text)
  end
end
