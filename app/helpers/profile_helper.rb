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

  def square_logo_for(company, size: 'normal', className: '')
    content_tag :div, class: "avatar avatar--#{size} #{className}", id: 'companyLogoContainer' do
      image_tag((company.avatar.try(:file_url) || 'avatar.png'), class: 'logo', id: 'companyLogo', data: { 'center-vertically': '' })
    end
  end

  def logo_for(company)
    image_tag((company.avatar.try(:file_url) || 'avatar.png'), class: 'logo')
  end
end
