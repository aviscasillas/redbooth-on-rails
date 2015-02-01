module RedboothOnRails
  class ExternalApi
    attr_accessor :user

    def initialize(user)
      @user = user
    end

    def projects
      client.project(:index).all
    end

    private

    def session
      @session ||= RedboothRuby::Session.new(token: user.oauth_token)
    end

    def client
      @client ||= RedboothRuby::Client.new(session)
    end
  end
end
