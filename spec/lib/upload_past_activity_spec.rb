require 'rails_helper'
require './lib/upload_past_activity'

RSpec.describe UploadPastActivity do
  let(:user) do
    create(
      User,
      access_token: 'access',
      experience_points: 0,
    )
  end
  let(:client) { Moves::Client.new(user.access_token) }
  let(:data_hash) do
    [{
      'date' => '20151010',
      'summary' => [
        {
          'activity' => 'walking',
          'group' => 'walking',
          'duration' => 2188.0,
          'distance' => 1952.0,
          'steps' => 2842,
          'calories' => 115,
        },
        {
          'activity' => 'cycling',
          'group' => 'cycling',
          'duration' => 1096.0,
          'distance' => 3177.0,
          'calories' => 87,
        },
      ],
      'caloriesIdle' => 1694,
      'lastUpdate' => '20151011T005706Z',
    },
    {
      'date' => '20151010',
      'summary' => [
        {
          'activity' => 'walking',
          'group' => 'walking',
          'duration' => 2188.0,
          'distance' => 1952.0,
          'steps' => 2842,
          'calories' => 115,
        },
        {
          'activity' => 'cycling',
          'group' => 'cycling',
          'duration' => 1096.0,
          'distance' => 3177.0,
          'calories' => 87,
        },
      ],
      'caloriesIdle' => 1694,
      'lastUpdate' => '20151011T005706Z',
    }]
  end

  before do
    allow(client).to receive(:daily_summary).and_return(data_hash)
  end

  specify do
    described_class.call(client: client, user: user)
    expect(user.experience_points).to be_within(0.01).of(2474.6)
  end
end
