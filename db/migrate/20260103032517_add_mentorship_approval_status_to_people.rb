class AddMentorshipApprovalStatusToPeople < ActiveRecord::Migration[7.1]
  def change
    add_column :people, :mentorship_approval_status, :string, default: nil
    add_index :people, :mentorship_approval_status
  end
end
