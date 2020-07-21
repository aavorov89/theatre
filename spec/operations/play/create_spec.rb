# frozen_string_literal: true

require 'rails_helper'

describe ::Play::Create do
  subject(:result) { described_class.call(params: params) }

  let(:params) do
    {
      name: play_name,
      begin_date: play_begin_date,
      end_date: play_end_date
    }
  end

  let(:play_name) { 'Hamlet' }
  let(:play_begin_date) { nil }
  let(:play_end_date) { nil }

  context 'with empty params' do
    let(:params) { {} }

    it 'returns not successful operation result' do
      expect(result).to be_failure
    end

    it 'returns model is persisted' do
      expect(result[:model].persisted?).to be_falsey
    end
  end

  context 'with valid params' do
    let(:play_begin_date) { '2020-08-20' }
    let(:play_end_date) { '2020-08-30' }

    it 'returns successful operation result' do
      expect(result).to be_success
    end

    it 'returns model is persisted' do
      expect(result[:model].persisted?).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:play_begin_date) { '2020-08-20' }

    it 'returns not successful operation result' do
      expect(result).to be_failure
    end

    it 'returns model is not persisted' do
      expect(result[:model].persisted?).to be_falsey
    end

    it 'returns end date must be filled' do
      expect(result[:errors]).to include(end_date: ['must be filled'])
    end
  end

  context 'dates backwards' do
    let(:play_begin_date) { '2020-08-20' }
    let(:play_end_date) { '2020-07-30' }

    it 'returns not successful operation result' do
      expect(result).to be_failure
    end

    it 'returns model is not persisted' do
      expect(result[:model].persisted?).to be_falsey
    end

    it 'returns date error' do
      expect(result[:errors]).to include(message: 'start date must be earlier than end date')
    end
  end

  context 'dates duplication' do
    let(:play_begin_date) { '2020-08-20' }
    let(:play_end_date) { '2020-08-30' }

    before do
      ::Play::Create.call(params: params)
    end

    it 'returns not successful operation result' do
      expect(result).to be_failure
    end

    it 'returns model is not persisted' do
      expect(result[:model].persisted?).to be_falsey
    end

    it 'returns date error' do
      expect(result[:errors]).to include(message: 'this time slot is already taken')
    end
  end

  context 'dates intersection' do
    before do
      params =
        {
          name: play_name,
          begin_date: '2020-08-15',
          end_date: '2020-08-20'
        }

      ::Play::Create.call(params: params)
    end

    let(:play_begin_date) { '2020-08-19' }
    let(:play_end_date) { '2020-08-30' }

    it 'returns not successful operation result' do
      expect(result).to be_failure
    end

    it 'returns model is not persisted' do
      expect(result[:model].persisted?).to be_falsey
    end

    it 'returns date error' do
      expect(result[:errors]).to include(message: 'this time slot is already taken')
    end
  end

  context 'dates close intersection' do
    before do
      params =
        {
          name: play_name,
          begin_date: '2020-08-15',
          end_date: '2020-08-20'
        }

      ::Play::Create.call(params: params)
    end

    let(:play_begin_date) { '2020-08-21' }
    let(:play_end_date) { '2020-08-30' }

    it 'returns successful operation result' do
      expect(result).to be_success
    end

    it 'returns model is persisted' do
      expect(result[:model].persisted?).to be_truthy
    end
  end
end
