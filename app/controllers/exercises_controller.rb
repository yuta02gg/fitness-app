class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise, only: [:edit, :update, :destroy]

  def index
    @keyword = params[:keyword]
    @exercises = current_user.exercises.active.search_by_name(@keyword).order(created_at: :desc)
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      redirect_to exercises_path, notice: "種目を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercises_path, notice: "種目を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @exercise.soft_delete
      redirect_to exercises_path, notice: "種目を削除しました"
    else
      redirect_to exercises_path, alert: "種目を削除できませんでした"
    end
  end

  private

  def set_exercise
    @exercise = current_user.exercises.active.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:name, :body_part, :memo)
  end
end
