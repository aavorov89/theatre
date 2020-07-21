# frozen_string_literal: true

class ApplicationOperation < Trailblazer::Operation
  def validation_error(context, _)
    context[:errors] = context['contract.default'].errors.messages
  end
end
