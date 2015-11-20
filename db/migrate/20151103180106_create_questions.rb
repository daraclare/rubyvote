class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.string :kind
      t.references :poll

      t.timestamps null: false
    end
  end
end
