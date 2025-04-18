module SessionTestHelper
  def parsed_cookies
    ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
  end

  def sign_in(user)
    user = users(user) unless user.is_a? User
    post session_url, params: { email: user.email, password: "secret123456" }
    assert cookies[:session_token].present?

    Current.session = Session.last
  end

  def sign_out
    delete session_url
    Current.session = nil
    assert_not cookies[:session_token].present?
  end
end
