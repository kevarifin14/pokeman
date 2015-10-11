require 'method_object'

UploadPastActivity = MethodObject.new(:client, :user) do
  def call
    add_experience_points
  end

  private

  def add_experience_points
    daily_summaries.each do |daily_summary|
      daily_summary.each do |activity|
        update_experience(activity)
      end
    end
  end

  def update_experience(daily_summary)
    user.update(
      experience_points:
        activity_conversion(daily_summary) + user.experience_points,
    )
    user.reload
  end

  def activity_conversion(daily_summary)
    experience_points = 0
    if activity(daily_summary) == 'walking'
      experience_points = daily_summary.fetch('steps') * 0.1
    elsif activity(daily_summary) == 'running'
      experience_points = daily_summary.fetch('steps') * 0.3
    elsif activity(daily_summary) == 'cycling'
      experience_points = daily_summary.fetch('distance') * 0.3
    end
    experience_points
  end

  def activity(daily_summary)
    daily_summary.fetch('activity')
  end

  def daily_summaries
    summaries = []
    data_hash.each do |data|
      summaries << data.fetch('summary')
    end
    summaries
  end

  def data_hash
    client.daily_summary(pastDays: 31)
  end
end
