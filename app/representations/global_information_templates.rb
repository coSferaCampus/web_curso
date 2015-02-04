module GlobalInformationTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add lambda{ |file_resource| file_resource.id.to_s }, as: :id
      t.add :name
      t.add :value
      t.add :created_at
    end
  end
end
