class AddHiddenTextToMessage < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :hidden_text, :text
  end
end
