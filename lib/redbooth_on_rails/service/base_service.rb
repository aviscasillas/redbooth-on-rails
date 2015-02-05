module RedboothOnRails
  module Service
    class BaseService
      attr_accessor :client
      def initialize(client)
        self.client = client
      end
    end
  end
end
