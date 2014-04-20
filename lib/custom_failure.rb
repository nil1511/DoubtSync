class CustomFailure < Devise::FailureApp
  def respond
    if flash[:timedout] && flash[:alert]
      flash.keep(:timedout)
      flash.keep(:alert)
    else
      flash[:alert] = i18n_message
    end

    if http_auth?
      http_auth
    else
      redirect_to root_url
    end
  end
end