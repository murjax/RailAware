class Locomotive < ActiveRecord::Base
  belongs_to :report
  validates :number, presence: true
  validates :loco_type, presence: true
  validates :railroad, presence: true
end
