module SubjectTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add :id
      t.add :name
      t.add lambda{ |theme| theme.name.parameterize }, as: :name_parameterize
      t.add :themes
    end
  end
end
