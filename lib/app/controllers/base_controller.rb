require_relative '../views/view.rb'

class BaseController
  def initialize(repository)
    @repository = repository
    @view = View.new
  end

  def list
    @view.display_all(@repository.all)
  end

  def add
    object = create_object
    @repository.add(object)
    object
  end

  def delete
    id = @view.ask_id
    @repository.delete(id)
  end
end
