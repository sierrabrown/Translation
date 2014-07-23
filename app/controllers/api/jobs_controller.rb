module Api
  class JobsController < ApiController
    def create
      @job = current_user.jobs.new(job_params)

      if @job.save
        render json: @job
      else
        render json: @job.errors.full_messages, status: :unprocessable_entity
      end
    end

    def destroy
      @job = current_user.jobs.find(params[:id])
      @job.try(:destroy)
      render json: {}
    end

    def index
      @jobs = current_user.jobs
      render json: @jobs
    end

    def show
      @job = Job.find(params[:id])

      if @job
        render :show
      else
        render json: ["This job doesn't exist"], status: 403
      end
    end

    private

    def job_params
      params.require(:job).permit(:title)
    end
  end
end
