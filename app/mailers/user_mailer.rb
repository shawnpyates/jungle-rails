class UserMailer < ApplicationMailer

    default from: 'no-reply@jungle.com'

    def payment_email(order)
        @order = order
        mail(to: order.email, subject: "Thank you for your order #{order.id}!")
    end

    
end
