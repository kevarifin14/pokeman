require 'method_object'

UpdateActivity = MethodObject.new(:client, :user) do
  def call
    add_experience_points
  end

  private

  def add_experience_points
    byebug
    selected_activities.each do |activity_log|
      activity_log.each do |activity|
        update_experience(activity)
      end
    end
  end

  def update_experience(activity)
    user.update(
      experience_points:
        activity_conversion(activity) + user.experience_points,
    )
    user.reload
  end

  def activity_conversion(activity)
    experience_points = 0
    if activity_type(activity) == 'walking'
      experience_points = activity.fetch('steps') * 0.1
    elsif activity_type(activity) == 'running'
      experience_points = activity.fetch('steps') * 0.3
    elsif activity_type(activity) == 'cycling'
      experience_points = activity.fetch('distance') * 0.3
    end
    experience_points
  end

  def activity_type(activity)
    activity.fetch('activity')
  end

  def selected_activities
    selected_activities_array = []
    selected_segments.each do |segment|
      selected_activities_array << segment.fetch('activities')
    end
    selected_activities_array
  end

  def selected_segments
    parsed_selected_segments = []
    segments.each do |segment|
      parsed_selected_segments << parse_segment(segment)
    end
    parsed_selected_segments.flatten
  end

  def parse_segment(segment)
    segment.select do |move|
      move.fetch('endTime').to_datetime > last_updated
    end
  end

  def segments
    array_segments = []
    data_hash.each do |data|
      array_segments << data.fetch('segments')
    end
    array_segments
  end

  def data_hash
    client.daily_activities(from: last_updated, to: Time.now)
  end

  def last_updated
    user.updated_at.to_time
  end
end
