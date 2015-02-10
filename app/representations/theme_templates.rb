module ThemeTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add :id
      t.add :subject_id
      t.add :number
      t.add :title
      t.add :subtitles
    end

    api_accessible :html, :extend => :base do |t|
      t.add :html
    end
  end
end
