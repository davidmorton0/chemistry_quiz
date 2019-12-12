module UsersHelper
  
  def format_time(time)
    return "-" if !time
    hours = time >= 3600 ? "#{time / 3600}h " : ""
    minutes = time >= 60 ? "#{(time % 3600) / 60}m " : ""
    seconds = "#{time % 60}s"
    return "#{hours}#{minutes}#{seconds}"
  end
end