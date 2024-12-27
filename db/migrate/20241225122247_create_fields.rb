class CreateFields < ActiveRecord::Migration[8.0]
  def change
    create_table :fields do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.belongs_to :tenant, null: false
      t.jsonb :data

      t.timestamps default: -> { 'now()' }
    end
  end
end
