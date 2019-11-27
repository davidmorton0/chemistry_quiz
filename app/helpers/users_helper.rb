module UsersHelper

  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
  
  def format_time(time)
    hours = time >= 3600 ? "#{time / 3600}h " : ""
    minutes = time >= 60 ? "#{(time % 3600) / 60}m " : ""
    seconds = "#{time % 60}s"
    return "#{hours}#{minutes}#{seconds}"
  end
end