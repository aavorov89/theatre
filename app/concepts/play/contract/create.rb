class Play::Contract::Create < Reform::Form
  property :name
  property :begin_date
  property :end_date

  validates :name, presence: true
  validates :begin_date, presence: true
  validates :end_date, presence: true
end