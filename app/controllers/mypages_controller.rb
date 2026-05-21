class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    @current_date = params[:month].present? ? Date.parse(params[:month]) : Date.current
    @start_date = @current_date.beginning_of_month.beginning_of_week(:sunday)
    @end_date = @current_date.end_of_month.end_of_week(:sunday)
    @calendar_dates = (@start_date..@end_date).to_a

    @training_records = current_user.training_records
                                    .includes(training_sets: :exercise)
                                    .where(trained_on: @start_date..@end_date)
                                    .index_by(&:trained_on)
  rescue ArgumentError
    redirect_to mypage_path, alert: "日付の指定が正しくありません"
  end
end
