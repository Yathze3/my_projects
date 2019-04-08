class Record < ActiveRecord::Base

  belongs_to :user

  validates :title, :year, presence: true
end
