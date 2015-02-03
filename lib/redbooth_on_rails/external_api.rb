module RedboothOnRails
  class ExternalApi
    attr_accessor :user, :session, :client

    def initialize(user)
      @user = user
    end

    def projects
      client.project(:index).all
    end

    def project(id)
      client.project(:show, id: id)
    end

    def task_lists(conditions)
      client.task_list(:index, conditions).all
    end

    def task_list_create(params)
      client.task_list(:create, params)
    end

    private

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

    def call_refresh
      session.client.get_token(grant_type: 'refresh_token',
                               refresh_token: user.oauth_refresh_token)
    end

    def uncache(*names)
      names.each { |name| send("#{name}=", nil) }
    end
  end
end
