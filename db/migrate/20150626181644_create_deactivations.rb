class CreateDeactivations < ActiveRecord::Migration
  def change
    create_table :deactivations do |t|
    	t.integer		:member_id
    	t.text			:reason
    	t.date 			:effective_date

      t.timestamps null: false
    end
  end
end
