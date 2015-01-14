module ThemeTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add lambda{ |theme| theme.id.to_s }, as: :id
      t.add lambda{ |theme| theme.subject_id.to_s }, as: :subject_id
      t.add :number
      t.add :title
      t.add :subtitles
      t.add :html
    end
  end
end

