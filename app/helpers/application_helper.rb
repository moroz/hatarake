module ApplicationHelper
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
    lang.to_s.upcase
  end

  def locale_link(lang)
    link_to locale_flag(lang), {lang: lang, ref: params[:ref]}, class: 'locale_link'
  end

  def edit_button(path)
    link_to fa_icon('pencil', text: I18n.t('actions.edit')), path, class: 'custom_button'
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

  def link_back
    link_to "&laquo; ".html_safe + t('link_back'), :back, class: 'link_back'
  end
end
