# frozen_string_literal: true

# create Plays table
class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.string :name
      t.date :begin_date
      t.date :end_date

      t.timestamps
    end
  end
end
