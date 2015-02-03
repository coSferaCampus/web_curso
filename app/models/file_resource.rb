class FileResource
  include Mongoid::Document
  include Mongoid::Timestamps

  acts_as_api
  include FileResourceTemplates

  field :name, type: String
  field :url,  type: String

  validates :name, presence: true, uniqueness: true
  validates :url,  presence: true
end
