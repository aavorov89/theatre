# frozen_string_literal: true

class Play::Delete < ApplicationOperation
  step Model(Play, :find_by)
  step :delete!

  def delete!(_options, model:, **)
    model.destroy
  end
end
