# Base helper module
module ApplicationHelper
  # Gets the class based on flash key
  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info alert-dismissible fade show'
    when 'success' then 'alert alert-success alert-dismissible fade show'
    when 'warning' then 'alert alert-warning alert-dismissible fade show'
    when 'danger' then 'alert alert-danger alert-dismissible fade show'
    when 'alert' then 'alert alert-danger alert-dismissible fade show'
    end
  end

  # Converts integer role to text
  def role_name(role)
    case role
    when 0 then 'Student'
    when 1 then 'Teacher'
    end
  end

  # Converts Datetime to text
  def format_datetime(datetime)
    return if datetime.nil?
    datetime.to_formatted_s(:long)
  end

  # Converts Time to text
  def format_time(time)
    return if time.nil?
    time.to_s(:time)
  end
end
