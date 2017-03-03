# Helper for SessionsController
module SessionsHelper
  def session_status_text(status)
    case status
    when 'awaiting_approval' then 'Awaiting Approval'
    when 'approved' then 'Approved'
    when 'used' then 'Used'
    end
  end
end
