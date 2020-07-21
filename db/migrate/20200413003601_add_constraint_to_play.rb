# frozen_string_literal: true

# adds unique date constraint
class AddConstraintToPlay < ActiveRecord::Migration[6.0]
  def up
    execute 'ALTER TABLE plays ADD CONSTRAINT unique_dates EXCLUDE USING gist'\
                " (daterange(begin_date, end_date, '[]') WITH &&)"
  end

  def down
    execute 'ALTER TABLE plays DROP CONSTRAINT unique_dates'
  end
end
