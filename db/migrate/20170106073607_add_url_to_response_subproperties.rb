class AddUrlToResponseSubproperties < ActiveRecord::Migration[5.0]
  def change
    add_column :response_subproperties, :url, :string
  end
end
