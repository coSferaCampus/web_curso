module UserTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add lambda{ |theme| theme.id.to_s }, as: :id
      t.add :email
    end
  end
end
