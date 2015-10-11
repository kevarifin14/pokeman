require 'rails_helper'
require './lib/update_activity'

RSpec.describe UpdateActivity do
  let(:user) do
    create(
      User,
      access_token: 'access',
      experience_points: 0,
      updated_at: 1.day.ago,
    )
  end
  let(:client) { Moves::Client.new(user.access_token) }
  let(:data_hash) do
    [{
      'date' => '20151010',
      'summary' => [{
        'activity' => 'walking',
        'group' => 'walking',
        'duration' => 2379.0,
        'distance' => 2115.0,
        'steps' => 3086,
        'calories' => 124,
        },
        {
          'activity' => 'cycling',
          'group' => 'cycling',
          'duration' => 1096.0,
          'distance' => 3177.0,
          'calories' => 87,
        }],
      'segments' =>
        [
          {
            'type' => 'place',
            'startTime' => '20151009T221705-0700',
            'endTime' => '20151010T013156-0700',
            'activities' => [{
              'activity' => 'walking',
              'group' => 'walking',
              'manual' => false,
              'startTime' => '20151010T010222-0700',
              'endTime' => '20151010T010846-0700',
              'duration' => 384.0,
              'distance' => 424.0,
              'steps' => 565,
              'calories' => 25
            }],
            'lastUpdate' => '20151010T093239Z',
          },
          {
            'type' => 'move',
            'startTime' => '20151010T013156-0700',
            'endTime' => '20151010T014127-0700',
            'activities' => [{
              'activity' => 'cycling',
              'group' => 'cycling',
              'manual' => false,
              'startTime' => '20151010T013156-0700',
              'endTime' => '20151010T014127-0700',
              'duration' => 571.0, 'distance' => 1526.0,
              'calories' => 42
            }],
            'lastUpdate' => '20151010T093255Z',
          },
          {
            'type' => 'place',
            'startTime' => '20151010T014128-0700',
            'endTime' => '20151010T152150-0700',
            'activities' => [
              {
                'activity' => 'walking',
                'group' => 'walking',
                'manual' => false,
                'startTime' => '20151010T105209-0700',
                'endTime' => '20151010T105239-0700',
                'duration' => 30.0,
                'distance' => 15.0,
                'steps' => 30,
                'calories' => 1
              },
              {
                'activity' => 'walking',
                'group' => 'walking',
                'manual' => false,
                'startTime' => '20151010T135455-0700',
                'endTime' => '20151010T135525-0700',
                'duration' => 30.0,
                'distance' => 21.0,
                'steps' => 41,
                'calories' => 1
              },
              {
                'activity' => 'walking',
                'group' => 'walking',
                'manual' => false,
                'startTime' => '20151010T141005-0700',
                'endTime' => '20151010T141205-0700',
                'duration' => 120.0,
                'distance' => 81.0,
                'steps' => 163,
                'calories' => 5
              },
            ],
            'lastUpdate' => '20151010T093255Z',
          }
        ]
      }
    ]
  end

  before do
    allow(client).to receive(:daily_activities).and_return(data_hash)
  end

  specify do
    described_class.call(client: client, user: user)
    expect(user.experience_points).to be_within(0.01).of(481.2)
  end
end
