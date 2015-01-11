class Subject
  include Mongoid::Document
  include Mongoid::Timestamps

  acts_as_api
  include SubjectTemplates

  field :name, type: String

  has_many :themes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
