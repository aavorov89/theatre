# frozen_string_literal: true

# parent class for serializers
class ApplicationSerializer < Representable::Decorator
  include Representable::JSON
end
