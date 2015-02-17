class FileResource
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :url,  type: String

  validates :name, presence: true, uniqueness: true
  validates :url,  presence: true
end
