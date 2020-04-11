class PlaysController < ApplicationController
  include Trailblazer::Rails::Controller

  def index
    run Play::Index
    render json: Play::Decorator.for_collection.new(result[:model]).to_json
  end

  def create
    run Play::Create

    if result.success?
      render json: Play::Decorator.new(result[:model]).to_json, status: :created
    else
      render json: result[:errors], status: :unprocessable_entity
    end
  end

  def destroy
    run Play::Delete
  end
end
