# Base helper module
module ApplicationHelper
  # Gets the class based on flash key
  def flash_class(level)
    case level
    when :notice then 'alert alert-info alert-dismissible fade in'
    when :success then 'alert alert-success alert-dismissible fade in'
    when :error then 'alert alert-error alert-dismissible fade in'
    when :alert then 'alert alert-error alert-dismissible fade in'
    end
  end
end
