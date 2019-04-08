class Artist < ActiveRecord::Base
  has_many :records, dependent: :destroy

  validates :name, presence: true
end
