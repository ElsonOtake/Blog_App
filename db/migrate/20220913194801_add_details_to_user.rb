class AddDetailsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :photo, :string
    add_column :users, :post_counter, :integer
  end
end
