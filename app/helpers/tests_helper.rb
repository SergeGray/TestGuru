module TestsHelper
  def timer_format(seconds)
    minutes, seconds = seconds.divmod(60)
    hours, minutes = minutes.divmod(60)
    "#{"%02d" % hours}:#{"%02d" % minutes}:#{"%02d" % seconds}"
  end
end
