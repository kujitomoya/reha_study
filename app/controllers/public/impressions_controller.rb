class Public::ImpressionsController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]

  def index
    if params[:latest]
      @impressions = Impression.latest.page(params[:page]).per(6)
    elsif params[:old]
      @impressions = Impression.old.page(params[:page]).per(6)
    elsif params[:favorite]
      impression_favorite_count = {}
      Impression.all.each do |impression|
      impression_favorite_count.store(impression, Favorite.where(impression_id: impression.id).pluck(:id).count)
      @impressions = Kaminari.paginate_array(impression_favorite_count.sort_by { |_, v| v }.reverse.to_h.keys).page(params[:page]).per(6)
      end
    else
      @impressions = Impression.all.page(params[:page]).per(6)
    end
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
    @comment = Comment.new
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

  def search
    search_word = params[:word].split(/[[:blank:]]+/)

    if search_word.blank?
      @impressions = Impression.all.page(params[:page]).per(10)
    else
      search_word.each_with_index do |keyword, index|
        @impressions = Impression.search(keyword) if index == 0
        @impressions = Impression.merge(@impressions.search(keyword), rewhere: true) if index != 0
      end
    end

    @impressions = @impressions.page(params[:page]).per(10)
    render :index
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