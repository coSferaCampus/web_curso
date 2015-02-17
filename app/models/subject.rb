class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  has_many :themes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
