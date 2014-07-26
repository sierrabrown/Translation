
module Api
  class JobsController < ApiController
    def create
      @job = current_user.jobs.new(job_params)
      if @job.save
        #@job.delay.print
        Job.build_and_translate(@job.id)
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
    
    def update
      @job = Job.find(params[:id])
      if @job.update_attributes(job_params)
        render json: @job
      else
        render json: ["major problems"], status: 403
      end
    end

    


    private

    def job_params
      params.require(:job).permit(:title, :description, :source_text, :machine_text, :target_text, :customer_id, :source_lang, :target_lang,
      :status, :price)
    end
  end
end
