# frozen_string_literal: true

class Play::Create < ApplicationOperation
  step Model(Play, :new)
  step Contract::Build(constant: PlayContract)
  step Contract::Validate()
  fail :validation_error

  step Rescue(ActiveRecord::StatementInvalid, handler: :persist_error) {
    step Contract::Persist()
  }

  def persist_error(exception, context)
    if exception.message.include?('unique_dates')
      message = 'this time slot is already taken'
    elsif exception.message.include?('range lower bound')
      message = 'start date must be earlier than end date'
    else
      raise exception
    end

    context[:errors] = { message: message }
  end
end
