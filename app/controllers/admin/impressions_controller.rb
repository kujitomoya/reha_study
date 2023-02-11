class Admin::ImpressionsController < ApplicationController
  def index
    @impressions = Impression.all.page(params[:page]).per(10)
  end

  def show
    @impression = Impression.find(params[:id])  
  end

  def destroy
    impression = Impression.find(params[:id])  # データ（レコード）を1件取得
    impression.destroy  # データ（レコード）を削除
    redirect_to impressions_path  # 投稿一覧画面へリダイレクト  
  end
end
