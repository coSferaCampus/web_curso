module UserTemplates
  extend ActiveSupport::Concern

  included do
    api_accessible :base do |t|
      t.add :id
      t.add :email
    end
  end
end
