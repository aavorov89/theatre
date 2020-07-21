# frozen_string_literal: true

# parent class for active records
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
