# frozen_string_literal: true

# serializer for play
class PlaySerializer < ApplicationSerializer
  include Representable::JSON

  property :id
  property :name
  property :begin_date
  property :end_date
end
