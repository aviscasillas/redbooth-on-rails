require 'rails_helper'
require 'redbooth_on_rails/service/base_service'

describe RedboothOnRails::Service::BaseService do
  let(:client) { double(:client) }
  subject { described_class.new(client) }
  its(:client) { is_expected.to be client }
end
