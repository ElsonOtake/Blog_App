class CreateUniqueAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :unique_analytics do |t|
      t.references :member, null: false, foreign_key: { on_delete: :cascade }
      t.references :visitor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
