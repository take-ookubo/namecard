class Division < ActiveRecord::Base
  belongs_to :company
  has_many :personal
end
