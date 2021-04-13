class UrlClassification < ApplicationRecord

  rails_admin do
    show do
      field  :url
      field  :classification
    end
    list do
      field  :url
      field  :classification
    end
    create do
      field  :url
      field  :classification
    end
    edit do
      field  :url
      field  :classification
    end
  end
end
