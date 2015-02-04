require 'rails_helper'
require 'redbooth_on_rails/service'

describe RedboothOnRails::Service do
  let(:user) { double(:user) }
  let(:app) { double(:app, current_user: user).extend(described_class) }
  subject { app.redbooth }
  it { is_expected.to be_a_kind_of RedboothOnRails::Service::Api }
  its(:user) { is_expected.to be user}
end
