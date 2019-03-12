class AddQuantityToTickets < ActiveRecord::Migration[5.1]
  def change
    add_column :tickets, :quantity, :integer
  end
end
