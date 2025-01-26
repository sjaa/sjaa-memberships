class RenameGroupsToRoles < ActiveRecord::Migration[7.1]
  def change
    remove_index :people_roles, name: "index_groups_people_on_group_id_and_person_id"
    remove_index :people_roles, name: "index_groups_people_on_person_id_and_group_id"
    rename_table :groups, :roles
    rename_table :groups_people, :people_roles
    rename_column :people_roles, :group_id, :role_id
    add_index :people_roles, :person_id
    add_index :people_roles, :role_id
  end
end
