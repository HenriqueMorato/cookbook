class ChangeMethodFieldOnRecipe < ActiveRecord::Migration[5.1]
  def change
    rename_column :recipes, :method, :cook_method
  end
end
