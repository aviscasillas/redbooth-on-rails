class TaskList
  include ActiveModel::Model

  attr_accessor :project_id, :name
  validates :name, presence: true

  def to_provider
    as_json
  end
end
