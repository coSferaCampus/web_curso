module GlobalInformationTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :value
      t.add :created_at
    end
  end
end
