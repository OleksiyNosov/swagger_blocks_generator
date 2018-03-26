require 'spec_helper'
require 'swagger_blocks_generator'

RSpec.describe SwaggerBlocksGenerator do
  subject { described_class.new }

  let(:data) { { id: 5, title: 'test' } }

  describe '#generate_properties' do
    it 'returns generated properties' do
      expect(subject.generate_properties(data)).to eq \
%q(property :id do
  key :type, :integer
  key :format, :int64
  key :example, 5
end
property :title do
  key :type, :string
  key :example, 'test'
end)
    end
  end
end
