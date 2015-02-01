require 'rails_helper'
require 'redbooth_on_rails/external_api'

describe RedboothOnRails::ExternalApi do
  let(:user) { double(User, oauth_token: 'some token') }
  let(:external_api) { described_class.new(user) }

  let(:client) { double(:client) }
  let(:session) { double(:session) }

  describe '#projects' do
    let(:projects) { double(:projects) }
    let(:project) { double(:project, all: projects) }
    subject { external_api.projects }

    before do
      expect(client).to receive(:project).with(:index).and_return(project)
      expect(RedboothRuby::Client).to receive(:new).and_return(client)
      expect(RedboothRuby::Session).to receive(:new)
        .with(token: user.oauth_token)
        .and_return(session)
    end

    it { is_expected.to eq projects }
  end
end
