# Helper functions for Devise Views
module DeviseHelper
  def devise_error_messages!
    return '' unless devise_error_messages?

    messages = safe_join resource.errors.full_messages.map { |msg| content_tag(:p, msg, class: 'm-b-0 m-t-1') }

    html = content_tag :div, id: 'error_explanation', class: 'alert alert-danger', role: 'alert' do
      safe_join([content_tag(:h4, 'The following errors occured:', class: 'alert-heading m-b-1'), messages])
    end

    html
  end

  def devise_error_messages?
    !resource.errors.empty?
  end
end
