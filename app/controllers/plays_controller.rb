# frozen_string_literal: true

# controller to deal with plays
class PlaysController < ApplicationController
  include Trailblazer::Rails::Controller

  def index
    run Play::Index
    render json: serialize(result, for_collection: true)
  end

  def create
    run Play::Create

    if result.success?
      render json: serialize(result), status: :created
    else
      render_error(result)
    end
  end

  def destroy
    run Play::Delete
  end
end
