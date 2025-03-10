class AddEndDateToMembership < ActiveRecord::Migration[7.1]
  def change
    add_column :memberships, :end, :datetime

    Membership.all.each do |membership|
      if(membership.start && membership.term_months)
        membership.end = (membership.start + membership.term_months.months).end_of_month
        membership.save
      end
    end
  end
end
