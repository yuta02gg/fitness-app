class Users::GuestSessionsController < ApplicationController
  def create
    user = User.guest
    sign_in user
    redirect_to mypage_path, notice: "ゲストユーザーとしてログインしました"
  end
end
