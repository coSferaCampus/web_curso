class FileResourceSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :created_at
end
