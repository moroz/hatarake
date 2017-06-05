module ProfileHelper
  def profile_section(heading = "Foobar", options = {}, &block)
    section_classes = 'row profile-section--padding profile-section--border profile-section--margin' 
    header_classes = 'profile-section__heading' 
    if options[:color]
      section_classes << " profile-section--color-#{options[:color]}"
    end
    content_tag :section, class: section_classes do
      concat content_tag :h3, heading, class: header_classes if heading
      concat content_tag(:div, capture(&block), class: 'profile-section__content')
    end
  end

  def avatar_for(user, size = :thumb)
    url = user.avatar.present? ?
      user.avatar.file_url :
      image_path('avatar.png')
    content_tag :div, nil, class: "avatar avatar--#{size} shadow", style: "background-image: url(#{url})"
  end

  def section_link(text, url, *custom_classes)
    classes = custom_classes.map { |c| 'custom_button--' + c.to_s }.join(' ')
    link_to text, url, class: 'custom_button ' + classes
  end

end
