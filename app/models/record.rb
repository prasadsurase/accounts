class Record < ActiveRecord::Base
  validates :date, :title, :amount, presence: true
  validates :amount,  numericality: true
end
