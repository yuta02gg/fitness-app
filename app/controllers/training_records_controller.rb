class TrainingRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_training_record, only: [:show, :edit, :update, :destroy]
  before_action :set_exercises, only: [:new, :create, :edit, :update]

  def index
    @training_records = current_user.training_records
                                    .includes(training_sets: :exercise)
                                    .order(trained_on: :desc)
  end

  def show
  end

  def new
    @training_record = current_user.training_records.new(trained_on: params[:trained_on] || Date.current)
    build_training_sets
  end

  def create
    @training_record = current_user.training_records.new(training_record_params)

    if @training_record.save
      redirect_to training_record_path(@training_record), notice: "トレーニング記録を登録しました"
    else
      build_training_sets
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    build_training_sets
  end

  def update
    if @training_record.update(training_record_params)
      redirect_to training_record_path(@training_record), notice: "トレーニング記録を更新しました"
    else
      build_training_sets
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @training_record.destroy
    redirect_to training_records_path, notice: "トレーニング記録を削除しました"
  end

  private

  def set_training_record
    @training_record = current_user.training_records.find(params[:id])
  end

  def set_exercises
    @exercises = current_user.exercises.active.order(:name)
  end

  def build_training_sets
    blank_count = 5 - @training_record.training_sets.size
    blank_count.times do
      @training_record.training_sets.build
    end
  end

  def training_record_params
    params.require(:training_record).permit(
      :trained_on,
      :memo,
      training_sets_attributes: [
        :id,
        :exercise_id,
        :set_number,
        :weight,
        :reps,
        :memo,
        :_destroy
      ]
    )
  end
end
