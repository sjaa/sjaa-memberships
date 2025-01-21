class DonationItem < ApplicationRecord
  belongs_to :donation
  belongs_to :equipment
  has_many :phases, ->{order(date: :asc)}, class_name: 'DonationPhase'

  def phase_attributes=(attrs)
    _phases = []
    attrs.each do |phase_hash|
      _phase = phase_hash[:id].present? ? DonationPhase.find(phase_hash[:id]) : DonationPhase.new
      _phase.update(phase_hash)
      _phases << _phase
    end

    self.phases = _phases
  end

  def equipment_attributes=(equipment_attr)
    _equipment = equipment_attr[:id].present? ? Equipment.find(equipment_attr[:id]) : Equipment.new
    _equipment.update(equipment_attr)
    self.equipment = _equipment
  end
end
