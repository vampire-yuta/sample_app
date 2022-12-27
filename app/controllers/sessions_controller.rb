class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    # ユーザーがデータベース内に存在し、かつ、認証に成功した場合
    if @user && @user&.authenticate(params[:session][:password])
      if @user.activated?
        forwarding_url = session[:forwarding_url]
        # ユーザーログイン後にユーザー情報のページへリダイレクトする
        reset_session #ログイン前に固定セッションをリセットする
        params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
        # redirect_to @user
        log_in @user
        redirect_to forwarding_url || @user
      else
        message = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラーメッセージを表示する 
      flash.now[:danger] = "Invalid email/password combination" #本当は正しくない
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end
end
