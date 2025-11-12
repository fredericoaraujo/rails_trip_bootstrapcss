class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :super_category_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    # Adicionando o índice para a chave estrangeira (super_category_id)
    add_index :categories, :super_category_id
  end
end
