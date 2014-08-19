class CreateJobTitles < ActiveRecord::Migration
  def change
    create_table :job_titles do |t|
      t.string :name, null: false
      t.timestamps null: false
    end
    add_index :job_titles, :name, unique: true
  end
end
