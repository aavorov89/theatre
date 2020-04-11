class Play::Delete < Trailblazer::Operation
  step Model(Play, :find_by)
  step :delete!

  def delete!(options, model:, **)
    model.destroy
  end
end