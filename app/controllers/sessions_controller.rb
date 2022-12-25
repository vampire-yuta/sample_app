class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # ユーザーがデータベース内に存在し、かつ、認証に成功した場合
    if user&.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページへリダイレクトする
      reset_session #ログイン前に固定セッションをリセットする
      log_in user
      redirect_to user
    else
      # エラーメッセージを表示する 
      flash.now[:danger] = "Invalid email/password combination" #本当は正しくない
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    redirect_to root_url, status: :see_other
  end
end
