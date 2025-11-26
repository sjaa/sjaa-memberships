class MeetupEvent < ApplicationRecord
  validates :meetup_id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :time, presence: true

  scope :upcoming, -> { where('time >= ?', Time.current).order(time: :asc) }
  scope :past, -> { where('time < ?', Time.current).order(time: :desc) }
end
