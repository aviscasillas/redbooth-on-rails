# -*- coding: utf-8 -*-
module ApplicationHelper
  def bootstrap_class_for(type)
    { success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info' }.fetch(type, type.to_s)
  end

  def flash_message(type, msg)
    content_tag :div, class: "alert #{bootstrap_class_for(type.to_sym)}" do
      concat flash_close_button
      concat msg
    end
  end

  def flash_close_button
    content_tag(:button, class: 'close', data: { dismiss: 'alert' }) { '×' }
  end

  def title(i18nt, params = {})
    content_tag(:h2) { t("controllers.#{i18nt}.title", params) }
  end

  def default_description
    content_tag(:em, class: 'text-muted') { t('helpers.default_description') }
  end

  def description(description)
    text = description.present? ? description : default_description
    text.html_safe
  end

  def created_on(datetime)
    t('helpers.created_on', datetime: Time.at(datetime).strftime('%c'))
  end

  def glyphicon(icon_name)
    content_tag(:span, class: "glyphicon glyphicon-#{icon_name}") { '' }
  end

  def link_to_login(options = {})
    text = "#{glyphicon('user')} #{t('helpers.login_with')} Redbooth".html_safe
    link_to(text, '/auth/redbooth', options)
  end

  def link_to_logout
    text =
      "#{t('helpers.logout')} <b>#{current_user.name}</b> #{glyphicon('log-out')}".html_safe
    link_to(text, sign_out_path)
  end

  def btn_link_to(text, path, options = {})
    options_class = options.delete(:class) || ''
    opts = { class: "#{options_class} btn btn-primary" }
    link_to text, path, options.merge(opts)
  end
end
