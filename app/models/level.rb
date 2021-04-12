class Level < ApplicationRecord
  has_many :url_classifications

  rails_admin do
    show do
      field  :level
      field  :name
    end
    list do
      field  :level
      field  :name
    end
    create do
      field  :level
      field  :name
    end
    edit do
      field  :level
      field  :name
    end
  end
end
