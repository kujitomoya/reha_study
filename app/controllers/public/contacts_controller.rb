class Public::ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, current_customer).deliver
      flash[:notice] ='お問い合わせ内容を送信しました'
      redirect_to impressions_path
    else
      render :new
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :content)
    end
end