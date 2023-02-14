class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail(
      from: ENV['KEY'],  #送信元アドレス
      to: contact.email,       #送信先アドレス
      subject: 'お問い合わせを承りました',  #メールの件名
      bcc: ENV['KEY']    #BCC送信先アドレス
    )
  end
end