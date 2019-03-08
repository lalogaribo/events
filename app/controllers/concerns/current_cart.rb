module CurrentCart
	private

	def set_cart
		@cart = Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound => e
		render json: e, status: 404
		@cart = Cart.create
		session[:cart_id] = @cart.id
	end
end