class Practice < ApplicationRecord
  belongs_to :user
  validates :time, presence: true, :numericality => {only_integer: true, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 24 }
end
