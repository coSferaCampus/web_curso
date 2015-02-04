class GlobalInformation
  include Mongoid::Document
  include Mongoid::Timestamps

  acts_as_api
  include GlobalInformationTemplates

  field :name, type: String
  field :value,  type: String

  validates :name, presence: true, uniqueness: true
  validates :value,  presence: true
end
