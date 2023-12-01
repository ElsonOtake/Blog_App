class CreateLengthAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :length_analytics do |t|
      t.integer :comment_length
      t.references :member, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
