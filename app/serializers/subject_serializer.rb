class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :name_parameterize

  has_many :themes

  def name_parameterize
    object.name.parameterize
  end
end
