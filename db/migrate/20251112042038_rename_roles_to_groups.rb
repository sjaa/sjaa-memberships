class RenameRolesToGroups < ActiveRecord::Migration[7.1]
  def change
    # Rename the roles table to groups
    rename_table :roles, :groups

    # Rename the people_roles join table to groups_people
    rename_table :people_roles, :groups_people

    # Rename the role_id column to group_id in the join table
    rename_column :groups_people, :role_id, :group_id

    # Rename the role_id column to group_id in equipment table
    rename_column :equipment, :role_id, :group_id

    # Update indexes on groups_people table
    remove_index :groups_people, name: "index_people_roles_on_person_id" if index_exists?(:groups_people, :person_id, name: "index_people_roles_on_person_id")
    remove_index :groups_people, name: "index_people_roles_on_role_id" if index_exists?(:groups_people, :role_id, name: "index_people_roles_on_role_id")

    add_index :groups_people, :person_id, name: "index_groups_people_on_person_id" unless index_exists?(:groups_people, :person_id, name: "index_groups_people_on_person_id")
    add_index :groups_people, :group_id, name: "index_groups_people_on_group_id" unless index_exists?(:groups_people, :group_id, name: "index_groups_people_on_group_id")

    # Update index on equipment table
    remove_index :equipment, name: "index_equipment_on_role_id" if index_exists?(:equipment, :role_id, name: "index_equipment_on_role_id")
    add_index :equipment, :group_id, name: "index_equipment_on_group_id" unless index_exists?(:equipment, :group_id, name: "index_equipment_on_group_id")
  end
end
