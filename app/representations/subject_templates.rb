module SubjectTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add lambda{ |theme| theme.id.to_s }, as: :id
      t.add :name
      t.add lambda{ |theme| theme.name.parameterize }, as: :name_parameterize
      t.add :themes
    end
  end
end

