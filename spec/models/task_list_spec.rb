require 'rails_helper'
require 'shoulda/matchers'

describe TaskList do
  it { should validate_presence_of :name }

  describe '#to_provider' do
    let(:attributes) { { name: 'some name', project_id: 1} }
    subject { TaskList.new(attributes).to_provider }
    it { is_expected.to eq attributes }
  end
end
