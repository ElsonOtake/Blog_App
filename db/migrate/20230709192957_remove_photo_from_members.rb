class RemovePhotoFromMembers < ActiveRecord::Migration[7.0]
  def change
    remove_column :members, :photo
  end
end
