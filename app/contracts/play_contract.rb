# frozen_string_literal: true

# validates play attributes
class PlayContract < Reform::Form
  property :name
  property :begin_date
  property :end_date

  validation do
    params do
      required(:name).filled(:string)
      required(:begin_date).filled(:date)
      required(:end_date).filled(:date)
    end
  end
end
