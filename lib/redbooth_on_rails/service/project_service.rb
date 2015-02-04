require 'redbooth_on_rails/service/base_service'

module RedboothOnRails
  module Service
    class ProjectService < BaseService
      def all
        client.project(:index).all
      end

      def find(id)
        client.project(:show, id: id)
      end
    end
  end
end
