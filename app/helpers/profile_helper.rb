module ProfileHelper
  def avatar_for(user, size: 'normal', editable: false, className: '')
    url = if user.avatar.present?
            if user.avatar.vector?
              user.avatar.file_url
            else
              user.avatar.file_url(size)
            end
          else
            image_path('avatar.png')
          end
    content_tag :div, class: "avatar avatar--#{size} #{className}", style: "background-image: url(#{url})" do
      if editable
        link_to fa_icon('pencil'), edit_avatar_path, title: I18n.t('candidates.show.change_picture'), class: 'avatar__edit_button'
      end
    end
  end

  def logo_for(company)
    image_tag((company.avatar.present? ? company.avatar.file.normal.url : 'avatar.png'), class: 'logo')
  end
end
