# frozen_string_literal: true

# parent controller
class ApplicationController < ActionController::API
  UNPROCESSABLE_ENTITY = 422

  protected

  def serialize(object, for_collection: false)
    serializer_name = find_serializer(model_name(object[:model]))
    serializer_obj = init_serializer(object[:model], serializer_name, for_collection: for_collection)
    serializer_obj.to_json
  end

  def find_serializer(model_name)
    "#{model_name}Serializer".constantize
  end

  def init_serializer(entity, serializer, for_collection: false)
    if entity.is_a?(ActiveRecord::Relation) || for_collection
      serializer.for_collection.new(entity.to_a)
    else
      serializer.new(entity)
    end
  end

  def model_name(object)
    return object.name if object.is_a?(ActiveRecord::Relation)

    object.class.name
  end

  def render_error(result)
    render json: { errors: result[:errors] }, status: UNPROCESSABLE_ENTITY
  end
end
