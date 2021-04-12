class UrlClassification < ApplicationRecord
  belongs_to :level

  rails_admin do
    show do
      field  :level
      field  :url
    end
    list do
      field  :level
      field  :url
    end
    create do
      field  :level
      field  :url
    end
    edit do
      field  :level
      field  :url
    end
  end
end
