class Play::Index < Trailblazer::Operation
  step :model!

  def model!(options, *)
    options[:model] = Play.limit(1000)
  end
end