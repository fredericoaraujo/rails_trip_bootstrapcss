class Category < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  belongs_to :user, optional: true

  # Define o relacionamento pai (a categoria que a esta pertence)
  belongs_to :super_category,
              class_name: "Category",
              foreign_key: "super_category_id",
              optional: true # Permite que seja NULL

  # Define o relacionamento filho (as subcateorias que esta possui)
  has_many :sub_category,
           class_name: "Category",
           foreign_key: "super_category_id",
           dependent: :destroy

  scope :top_level, -> { where(super_category_id: nil) }
end
