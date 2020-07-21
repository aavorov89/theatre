# frozen_string_literal: true

class Play::Index < ApplicationOperation
  step :model!

  def model!(options, *)
    options[:model] = ::Play.limit(1000)
  end
end
