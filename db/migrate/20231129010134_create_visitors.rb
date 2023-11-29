class CreateVisitors < ActiveRecord::Migration[7.0]
  def change
    create_table :visitors do |t|
      t.string :user_agent
      t.references :member, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
