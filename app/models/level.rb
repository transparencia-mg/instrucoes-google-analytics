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
      field :level, :enum do
        enum do
          [1, 2, 3]
        end
      end
      field  :name
    end
    edit do
      field :level, :enum do
        enum do
          [1, 2, 3]
        end
      end
      field  :name
    end
  end
end
