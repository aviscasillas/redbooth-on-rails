require 'redbooth_on_rails/service/project_service'
require 'redbooth_on_rails/service/task_list_service'

module RedboothOnRails
  module Service
    class Api
      attr_accessor :user, :session, :client

      def initialize(user)
        @user = user
      end

      def project
        @project ||= RedboothOnRails::Service::ProjectService.new(client)
      end

      def task_list
        @task_list ||= RedboothOnRails::Service::TaskListService.new(client)
      end

      def session
        @session ||= RedboothRuby::Session.new(token: user.oauth_token)
      end

      def client
        refresh_token if user.oauth_expired?
        @client ||= RedboothRuby::Client.new(session)
      end

      def refresh_token
        call_refresh.tap do |resp|
          user.update_attributes(oauth_token: resp.token,
                                 oauth_refresh_token: resp.refresh_token)
        end
        uncache(:session, :client)
      end

      private

      def call_refresh
        session.client.get_token(grant_type: 'refresh_token',
                                 refresh_token: user.oauth_refresh_token)
      end

      def uncache(*names)
        names.each { |name| send("#{name}=", nil) }
      end
    end
  end
end
