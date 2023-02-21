class Admin::ImpressionsController < ApplicationController

  def index
    if params[:latest]
      @impressions = Impression.latest.page(params[:page]).per(6)
    elsif params[:old]
      @impressions = Impression.old.page(params[:page]).per(6)
    else
      @impressions = Impression.all.page(params[:page]).per(6)
    end
  end

  def show
    @impression = Impression.find(params[:id])
    @comment = Comment.new
  end

  def destroy
    impression = Impression.find(params[:id])  # データ（レコード）を1件取得
    impression.destroy  # データ（レコード）を削除
    redirect_to admin_impressions_path  # 投稿一覧画面へリダイレクト
  end
end
