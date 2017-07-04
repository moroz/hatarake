class AddFilenameToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_column :attachments, :filename, :string
  end
end
