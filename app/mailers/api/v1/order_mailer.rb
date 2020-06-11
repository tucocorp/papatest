class Api::V1::OrderMailer < ApplicationMailer
	def create(order)
		@order = order
		mail(from: "papatest <noreply@papatest.com>", to: @order.store.email, subject: "Nuevo Pedido")
	end
end
