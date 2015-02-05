require 'redbooth_on_rails/service/api'

module RedboothOnRails
  module Service
    def redbooth
      @redbooth ||= RedboothOnRails::Service::Api.new(current_user)
    end
  end
end
