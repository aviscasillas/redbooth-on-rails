require 'redbooth_on_rails/service/base_service'

module RedboothOnRails
  module Service
    class TaskListService < BaseService
      def all(conditions)
        client.task_list(:index, conditions).all
      end

      def create(params)
        client.task_list(:create, params)
      end
    end
  end
 end
