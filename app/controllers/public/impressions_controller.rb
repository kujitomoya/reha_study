class Public::ImpressionsController < ApplicationController
  def index
    @impressions = Impression.all  
  end

  def new
    @impression = Impression.new
  end
  
  def create
  end

  def show
  end

  def edit
  end
  
  def update
  end
end
