module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def user_gravatar(user, size: 80)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: 'profile-pic')
  end
end