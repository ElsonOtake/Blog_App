class CreateBrowserAnalytics < ActiveRecord::Migration[7.0]
  def change
    create_table :browser_analytics do |t|
      t.string :device
      t.string :platform
      t.references :member, null: false, foreign_key: { on_delete: :cascade }
      t.references :visitor, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
