module FileResourceTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add :url
      t.add :created_at
    end
  end
end
