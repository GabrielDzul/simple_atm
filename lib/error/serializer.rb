module Error
  class Serializer < ActiveModel::Serializer
    attributes :status,
               :message
  end
end