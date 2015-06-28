class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.string		:title
    	t.text			:content
    	t.integer		:post_type
    	t.datetime	:expires_at
    	t.text			:attachment_url
    	t.integer		:group_id
    	t.integer		:user_id
    	t.boolean		:public
    	t.integer		:approved_by

      t.timestamps null: false
    end
  end
end
