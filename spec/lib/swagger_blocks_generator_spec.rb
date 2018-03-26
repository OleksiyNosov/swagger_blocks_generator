require 'spec_helper'
require 'swagger_blocks_generator'

RSpec.describe SwaggerBlocksGenerator do
  subject { described_class.new }

  let(:model_attributes) { { id: 5, title: 'test' } }

  let(:input_attributes) { { attributes: model_attributes, required: [:id], name: 'model' } }

  describe '#generate_properties' do
    it 'returns generated properties' do
      expect(subject.generate_properties(model_attributes)).to eq \
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

  describe '#generate_model' do
    it 'returns generated model' do
      expect(subject.generate_model(input_attributes)).to eq \
%q(key :required, [:id]
key :type, :object
property :model do
  property :id do
    key :type, :integer
    key :format, :int64
    key :example, 5
  end
  property :title do
    key :type, :string
    key :example, 'test'
  end
end)
    end
  end

  describe '#generate_model' do
    it 'returns generated model' do
      expect(subject.generate_model(input_attributes)).to eq \
%q(key :required, [:id]
key :type, :object
property :model do
  property :id do
    key :type, :integer
    key :format, :int64
    key :example, 5
  end
  property :title do
    key :type, :string
    key :example, 'test'
  end
end)
    end
  end

  describe '#generate_swagger_shema_create' do
    it 'returns generated swagger shema' do
      expect(subject.generate_swagger_shema_create(input_attributes)).to eq \
%q(swagger_schema :InputModelCreate do
  key :required, [:id]
  key :type, :object
  property :model do
    property :id do
      key :type, :integer
      key :format, :int64
      key :example, 5
    end
    property :title do
      key :type, :string
      key :example, 'test'
    end
  end
end)
    end
  end

  describe '#generate_swagger_shema_create' do
    it 'returns generated swagger shema' do
      expect(subject.generate_swagger_shema_update(input_attributes)).to eq \
%q(swagger_schema :InputModelUpdate do
  key :required, [:id]
  key :type, :object
  property :model do
    property :id do
      key :type, :integer
      key :format, :int64
      key :example, 5
    end
    property :title do
      key :type, :string
      key :example, 'test'
    end
  end
end)
    end
  end

  describe '#generate_swagger_shema_create' do
    it 'returns generated swagger shema' do
      expect(subject.generate_swagger_shema_output(input_attributes)).to eq \
%q(swagger_schema :OutputModel do
  key :required, [:id]
  key :type, :object
  property :model do
    property :id do
      key :type, :integer
      key :format, :int64
      key :example, 5
    end
    property :title do
      key :type, :string
      key :example, 'test'
    end
  end
end)
    end
  end
end
