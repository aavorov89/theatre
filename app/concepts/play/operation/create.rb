class Play::Create < Trailblazer::Operation
  step Model(Play, :new)
  step Contract::Build( constant: Play::Contract::Create )
  step Contract::Validate()
  fail :validation_error

  step Rescue( ActiveRecord::StatementInvalid, handler: :persist_error ) {
    step Contract::Persist()
  }

  def validation_error(ctx, _)
    ctx[:errors] = ctx['contract.default'].errors.messages
  end

  def persist_error(_, ctx)
    ctx[:errors] = {message: 'check dates'}
  end
end