require 'rails_helper'

describe EventForm do 
  subject(:form) { described_class.new(options) }

  let(:options) { {} }
  let(:user) { create :user }

  context 'works fine' do
    let(:options) do
      { user: user, name: "New test event", description: "rspec event", start_time: "2021-10-01", period: "weekly", end_time: "2021-12-01" }
    end

    it 'expected to be valid' do
      expect(form.submit).to be_valid
    end
  end

  context 'no user and name provided' do
    let(:options) do 
      { description: "rspec event", start_time: "2021-10-01", period: "weekly", end_time: "2021-12-01" }
    end

    it 'expected to be not valid' do
      expect(form.submit).to be_falsey
      expect(form.errors.full_messages).to match_array(
        ["Name cannot be nil", "User cannot be nil"]
      )
    end
  end

  context 'no user provided' do
    let(:options) do 
      { name: "New test event", description: "rspec event", start_time: "2021-10-01", period: "weekly", end_time: "2021-12-01" }
    end

    it 'expected to be not valid' do
      expect(form.submit).to be_falsey
      expect(form.errors.full_messages).to match_array(
        ["User cannot be nil"]
      )
    end
  end
end
