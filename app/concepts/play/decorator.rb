class Play::Decorator < Representable::Decorator
  include Representable::JSON

  property :id
  property :name
  property :begin_date
  property :end_date
end