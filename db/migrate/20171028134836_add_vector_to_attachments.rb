class AddVectorToAttachments < ActiveRecord::Migration[5.1]
  def up
    add_column :attachments, :vector, :boolean, default: false
    return unless Rails.env.production?
    Avatar.find_each do |avatar|
      vector = avatar.file.content_type && (avatar.file.content_type == 'image/svg+xml')
      avatar.update_column(:vector, vector)
    end
  end

  def down
    remove_column :attachment, :vector, :boolean
  end
end
