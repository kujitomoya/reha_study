class Admin::FieldsController < ApplicationController
  def index
    @field = Field.new
    @fields = Field.all
  end

  def create
    @field = Field.new(field_params)
   if @field.save
    redirect_to admin_fields_path
   else
    @fields = Field.all
    render :index
   end
  end

  def edit
    @field = Field.find(params[:id])
  end

  def update
    @field = Field.find(params[:id])
    @field.update(field_params)
     redirect_to  admin_fields_path
  end
  
   private
   
  def field_params 
    params.require(:field).permit(:name)
  end
end
