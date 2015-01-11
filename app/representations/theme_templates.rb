module ThemeTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add lambda{ |theme| theme.id.to_s }, as: :id
      t.add :number
      t.add :title
      t.add :subtitles
    end
  end
end

