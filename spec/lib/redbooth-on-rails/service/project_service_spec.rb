require 'rails_helper'
require 'redbooth_on_rails/service/project_service'

describe RedboothOnRails::Service::ProjectService do
  let(:client) { double(:client) }
  let(:service) { described_class.new(client) }

  let(:expected_resource) { double(:expected_resource) }

  it 'Inherited BaseService' do
    expect(service).to be_a_kind_of RedboothOnRails::Service::BaseService
  end

  describe '#all' do
    let(:project) { double(:project) }
    before do
      expect(client).to receive(:project).with(:index).and_return(project)
      expect(project).to receive(:all).and_return(expected_resource)
    end
    subject { service.all }
    it { is_expected.to be expected_resource }
  end

  describe '#find' do
    let(:project_id) { 1 }
    before do
      expect(client).to receive(:project).with(:show, id: project_id)
        .and_return(expected_resource)
    end
    subject { service.find(project_id) }
    it { is_expected.to be expected_resource }
  end
end
