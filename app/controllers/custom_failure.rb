class CustomFailure < Devise::FailureApp
  def redirect_url
    # FIXME Failed login path
    root
  end

  def respond
    if http_auth?
      http_auth
    else
      redirect
    end
  end
end