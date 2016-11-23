module Account::UsersHelper
  def render_user_vip(user)
    if !user.is_vip?
      content_tag(:span,"", class:"fa fa-opera")
    else
      content_tag(:span,"", class:"fa fa-vimeo")
    end

  end
end
