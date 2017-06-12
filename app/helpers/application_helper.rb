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
      # We will handle HTML sanitization later
      # It should allow SOME HTML, like A, STRONG,
      # EM, BR, HR
      #filter_html:     true,
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true
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
      render partial: 'shared/errors', locals: { object: object }
    end
  end

  def locale_flag(lang)
    image_tag "/flag-#{lang}.svg", class: 'locale_flag'
  end

  def locale_link(lang)
    link_to locale_flag(lang), lang: lang
  end

  def body_tag(&block)
    options = {
      class: "#{controller_name} #{action_name}"
    }
    options = options.merge({'data-no-turbolink' => true}) if @disable_turbolinks
    content_tag :body, options do
      concat capture(&block)
    end
  end

  def edit_button(path)
    link_to fa_icon('pencil', text: I18n.t('actions.edit')), path, class: 'custom_button'
  end
end
