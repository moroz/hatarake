module ProfileHelper
  def profile_section(heading = "Foobar", options = {}, &block)
    content_tag :section, class: 'row row--padding row--border row--margin' do
      concat content_tag :h3, heading if heading
      concat capture(&block)
    end
  end

  def avatar_for(user, size = :large)
    url = 'avatar.png'
    if user.avatar.present?
      url = user.avatar.image.url
    end
    content_tag :div, nil, class: "avatar avatar--#{size}", style: "background-image: url(#{url})"
  end

end
