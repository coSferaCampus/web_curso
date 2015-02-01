class FileResource
  include Mongoid::Document
  include Mongoid::Timestamps

  acts_as_api
  include FileResourceTemplates

  mount_uploader :file, FileResourceUploader

  field :name, type: String

  validates :name, presence: true, uniqueness: true
  validates :file, presence: true
end
