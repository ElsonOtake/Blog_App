class CreateCounterAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :counter_analytics do |t|
      t.string :action
      t.integer :count, default: 0
      t.references :member, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
