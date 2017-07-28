module ApplicationHelper
  def mobile?
    browser.platform.android? || browser.platform.ios? || browser.platform.windows_mobile?
  end

  def javascript(*files)
    content_for(:javascripts) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:stylesheets) { stylesheet_link_tag(*files) }
  end

  def unsafe_markdown(text)
    options = {
      filter_html:     false,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    raw markdown.render(text)
  end

  def markdown(text)
    options = {
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true,
      hard_wrap: true
    }

    extensions = {
      autolink:           true,
      superscript:        true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    md = Redcarpet::Markdown.new(renderer, extensions)

    sanitize md.render(text)
  end

  def error_messages_for(object)
    content_tag :div, class: 'error_explanation', id: 'error_explanation' do
      render partial: 'errors', locals: { object: object }
    end
  end

  def locale_flag(lang)
    image_tag("flag-#{lang}.svg", class: 'locale_flag')
  end

  def locale_link(lang)
    link_to locale_flag(lang), {lang: lang, ref: params[:ref]}, class: 'locale_link'
  end

  def edit_button(path)
    link_to fa_icon('pencil', text: I18n.t('actions.edit')), path, class: 'button button--reduce-padding'
  end

  def divider_edit_button(path)
    link_to fa_icon('pencil', text: t('actions.edit')), path, class: 'card-divider__edit' 
  end

  def strip_http(url)
    URI(url.to_s).host
  end

  def add_soft_break_to_email(email)
    raw email.split('@').join('&#8203;&#64;')
  end

  def datetime_with_ordinal_day(dt)
    if I18n.locale == :pl
      I18n.l dt, format: :blog
    else
      dt.day.ordinalize + dt.strftime(" %B %Y, %I:%M %p")
    end
  end
end
