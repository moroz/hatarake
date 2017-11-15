# frozen_string_literal: true

module ProfileHelper
  def avatar_for(user, options = {})
    size = options[:size] || :normal
    avatar = user.avatar
    url = if avatar.present?
            avatar.thumb_url
          else
            default_avatar(user.sex)
          end
    content_tag :div, class: "avatar avatar--#{size} #{options[:class]}", style: "background-image: url(#{url})" do
      if options[:editable]
        link_to fa_icon('pencil'), edit_avatar_path, title: I18n.t('candidates.show.change_picture'),
                                                     class: 'avatar__edit_button'
      end
    end
  end

  def logo_for(company)
    image_tag((company.avatar.present? ? company.avatar.normal_url : default_avatar), class: 'logo')
  end

  def default_avatar(sex = 'male')
    if !sex || sex == 'male'
      image_path('avatar-male.svg')
    else
      image_path('avatar-female.svg')
    end
  end
end
