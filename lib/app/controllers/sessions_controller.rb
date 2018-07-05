require_relative '../views/session_view.rb'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionView.new
  end

  def list
    @view.display_employees(@repository.all)
  end

  def sign_in(params)
    @employee_repository.find_by_username(params["username"])
  end
end
