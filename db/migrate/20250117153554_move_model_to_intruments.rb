class MoveModelToIntruments < ActiveRecord::Migration[7.1]
  def change
    remove_column :equipment, :model, :string
    add_column :instruments, :model, :string
    rename_column :instruments, :name, :kind
  end
end
