class AddDescriptionLanguageToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :language, :string
    add_column :attachments, :description, :text
  end
end
