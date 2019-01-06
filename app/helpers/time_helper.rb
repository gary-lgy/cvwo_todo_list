module TimeHelper
  # convert timezone offset in minutes to the format accepted
  # by Time::change
  def timezone_offset
    offset_in_minutes = cookies[:timezone_offset].to_i
    timezone = Time.at(offset_in_minutes.abs.minutes).utc.strftime('%H:%M')
    if offset_in_minutes.positive?
      '-' + timezone
    else
      '+' + timezone
    end
  end

  # extract Time fields from a ActionController::Parameters instance
  def extract_time_from_params(params)
    Time.new(params['deadline(1i)'].to_i,
             params['deadline(2i)'].to_i,
             params['deadline(3i)'].to_i,
             params['deadline(4i)'].to_i,
             params['deadline(5i)'].to_i).change offset: timezone_offset
  end

  # convert UTC time from database to time in user's timezone
  # Time -> Time
  def utc_to_user_time(utc_time)
    utc_time -= cookies[:timezone_offset].to_i.minutes
    utc_time.change offset: timezone_offset
  end

end

# extend Time class to provide additional functionalities
class Time
  # return Time in a friendly format
  def friendly_format
    strftime '%H:%M, %a, %d %b %Y'
  end
end