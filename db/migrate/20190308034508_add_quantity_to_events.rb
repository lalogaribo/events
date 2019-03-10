class AddQuantityToEvents < ActiveRecord::Migration[5.1]
	def change
		add_column :events, :quantity, :integer
	end
end
