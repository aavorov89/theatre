require "rails_helper"

describe ::Play::Create do
  subject(:result) {described_class.(params: params)}

  context 'with empty params' do
    let(:params) { {} }
    it 'prohibits empty params' do
      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey
    end
  end

  context 'with valid params' do
    let(:params) {
      {
        name: "Hamlet",
        begin_date: "2020-08-20",
        end_date: "2020-08-30"
      }
    }

    it 'creates a play' do
      expect(result).to be_success
      expect(result[:model].name).to eq 'Hamlet'
      expect(result[:model].persisted?).to be_truthy
    end
  end

  context 'with invalid params' do
    let(:params) {
      {
        name: "Hamlet",
        begin_date: "2020-08-20",
      }
    }

    it 'creates a play' do
      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey
      expect(result[:errors]).to include(end_date: ['can\'t be blank'])
    end
  end

  context 'dates backwards' do
    let(:params) {
      {
          name: "Hamlet",
          begin_date: "2020-08-20",
          end_date: "2020-07-30"
      }
    }

    it 'creates a play' do
      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey
      expect(result[:errors]).to include(message: 'check dates')
    end
  end

  context 'dates duplication' do
    let(:params) {
      {
        name: "Hamlet",
        begin_date: "2020-08-20",
        end_date: "2020-08-30"
      }
    }

    before do
      ::Play::Create.(params: params)
    end

    it do
      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey
      expect(result[:errors]).to include(message: 'check dates')
    end
  end

  context 'dates intersection' do
    it do
      params_1 =
      {
        name: "Hamlet",
        begin_date: "2020-08-15",
        end_date: "2020-08-20"
      }

      params_2 =
      {
          name: "Hamlet",
          begin_date: "2020-08-19",
          end_date: "2020-08-30"
      }

      ::Play::Create.(params: params_1)
      result = ::Play::Create.(params: params_2)

      expect(result).to be_failure
      expect(result[:model].persisted?).to be_falsey
      expect(result[:errors]).to include(message: 'check dates')
    end
  end

  context 'dates close intersection' do
    it do
      params_1 =
          {
              name: "Hamlet",
              begin_date: "2020-08-15",
              end_date: "2020-08-20"
          }

      params_2 =
          {
              name: "Hamlet",
              begin_date: "2020-08-21",
              end_date: "2020-08-30"
          }

      ::Play::Create.(params: params_1)
      result = ::Play::Create.(params: params_2)

      expect(result).to be_success
      expect(result[:model].name).to eq 'Hamlet'
      expect(result[:model].persisted?).to be_truthy
    end
  end
end