module ProfileHelper
  def avatar_for(user, size: 'normal', editable: false, className: '')
    url = user.avatar.present? ?
      user.avatar.file_url :
      image_path('avatar.png')
    content_tag :div, class: "avatar avatar--#{size} #{className}", style: "background-image: url(#{url})" do
      if editable
        content_tag :div, class: 'avatar__edit_button' do
          link_to fa_icon('pencil'), edit_avatar_path, title: I18n.t('candidates.show.change_picture')
        end
      end
    end
  end
end
