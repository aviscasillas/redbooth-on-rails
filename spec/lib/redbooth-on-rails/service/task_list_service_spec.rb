require 'rails_helper'
require 'redbooth_on_rails/service/task_list_service'

describe RedboothOnRails::Service::TaskListService do
  let(:client) { double(:client) }
  let(:service) { described_class.new(client) }

  let(:expected_resource) { double(:expected_resource) }

  it 'Inherited BaseService' do
    expect(service).to be_a_kind_of RedboothOnRails::Service::BaseService
  end

  describe '#all' do
    let(:conditions) { { some: :condition } }
    let(:task_list) { double(:task_list) }
    before do
      expect(client).to receive(:task_list).with(:index, conditions)
        .and_return(task_list)
      expect(task_list).to receive(:all).and_return(expected_resource)
    end
    subject { service.all(conditions) }
    it { is_expected.to be expected_resource }
  end

  describe '#create' do
    let(:params) { { some: :param } }
    before do
      expect(client).to receive(:task_list).with(:create, params)
        .and_return(expected_resource)
    end
    subject { service.create(params) }
    it { is_expected.to be expected_resource }
  end
end
