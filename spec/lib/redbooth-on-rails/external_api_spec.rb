require 'rails_helper'
require 'redbooth_on_rails/external_api'

describe RedboothOnRails::ExternalApi do
  let(:user) { double(User, oauth_token: 'some token') }
  let(:external_api) { described_class.new(user) }

  let(:client) { double(:client) }
  let(:session) { double(:session) }

  before do
    expect(RedboothRuby::Client).to receive(:new).and_return(client)
    expect(RedboothRuby::Session).to receive(:new)
      .with(token: user.oauth_token)
      .and_return(session)
  end

  describe '#projects' do
    let(:projects) { double(:projects) }
    let(:project) { double(:project, all: projects) }
    subject { external_api.projects }

    before do
      expect(client).to receive(:project).with(:index).and_return(project)
    end

    it { is_expected.to eq projects }
  end

  describe '#task_list_create' do
    let(:params) { double(:params) }
    subject { external_api.task_list_create(params) }

    before do
      expect(client).to receive(:task_list).with(:create, params)
        .and_return(double)
    end

    it { is_expected.to_not be nil }
  end
end
