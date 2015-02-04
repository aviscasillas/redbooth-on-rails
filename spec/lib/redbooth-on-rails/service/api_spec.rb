require 'rails_helper'
require 'redbooth_on_rails/service/api'

describe RedboothOnRails::Service::Api do
  let(:api) { described_class.new(user) }

  let(:oauth_token) { 'some-token' }
  let(:oauth_refresh_token) { 'some-refresh-token' }
  let(:oauth_expired?) { false }
  let(:user) do
    double(:user,
           oauth_token: oauth_token,
           oauth_expired?: oauth_expired?,
           oauth_refresh_token: oauth_refresh_token)
  end

  describe '.initialize' do
    subject { api }
    its(:user) { is_expected.to be user }
  end

  describe '#session' do
    subject { api.session }

    context 'with no existing instance' do
      let(:params_for_new) { { token: user.oauth_token } }
      before do
        expect(RedboothRuby::Session).to receive(:new).with(params_for_new)
          .and_call_original
      end
      it { is_expected.to be_a_kind_of RedboothRuby::Session }
    end

    context 'with existing instance' do
      before do
        api.session
        expect(RedboothRuby::Session).to_not receive(:new)
      end
      it { is_expected.to be_a_kind_of RedboothRuby::Session }
    end
  end

  describe '#client' do
    let(:session) { RedboothRuby::Session.new(token: oauth_token) }

    before do
      expect(api).to receive(:session).and_return(session)
    end

    subject { api.client }

    context 'without expired token' do
      before { expect(api).to_not receive(:refresh_token) }
      it { is_expected.to be_a_kind_of RedboothRuby::Client }
    end

    context 'with expired token' do
      let(:oauth_expired?) { true }
      before { expect(api).to receive(:refresh_token) }
      it { is_expected.to be_a_kind_of RedboothRuby::Client }
    end

    context 'with existing instance' do
      before do
        api.client
        expect(RedboothRuby::Client).to_not receive(:new)
      end
      it { is_expected.to be_a_kind_of RedboothRuby::Client }
    end
  end

  describe '#refresh_token' do
    let(:refresh_params) do
      { grant_type: 'refresh_token', refresh_token: user.oauth_refresh_token }
    end
    let(:new_token) { 'new-token' }
    let(:new_refresh_token) { 'new-refresh-token' }
    let(:refresh_response) do
      double(:response, token: new_token, refresh_token: new_refresh_token)
    end

    let(:session_client) { double(:session_client) }

    let(:session) do
      double(:session, client: session_client)
    end

    before do
      expect(session_client).to receive(:get_token).with(refresh_params)
        .and_return(refresh_response)

      expect(user).to receive(:update_attributes)
        .with(oauth_token: new_token, oauth_refresh_token: new_refresh_token)

      api.client = double(:client)
      api.session = session
    end

    subject { api.refresh_token }

    it 'uncaches client and session instances' do
      subject
      expect(api.instance_variable_get(:@client)).to be_nil
      expect(api.instance_variable_get(:@session)).to be_nil
    end
  end
end
