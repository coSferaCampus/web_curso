class GlobalInformation
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :value,  type: String

  validates :name, presence: true, uniqueness: true
  validates :value,  presence: true
end
