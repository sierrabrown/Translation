
module Api
  class TasksController < ApiController
    
    before_filter :require_signed_in!
    
    def create
      @task = Task.new(task_params)
      @task.price = (@task.source_text.length * 0.001).round(2)
      @task.save
    end

    def index
      @tasks = Task.all
      debugger
      if (params['source_lang'] && params['target_lang'])
        @tasks = @tasks.where(source_lang: params['source_lang'], target_lang: params['target_lang'])
      elsif (params['status'])
        @tasks = @tasks.where(status: params['status'])
      end
      render json: @tasks
    end

    def show
      @task = Task.find(params[:id])

      if @task
        render json: @task
      else
        render json: ["This task doesn't exist"], status: 403
      end
    end
    
    def update
      @task = Task.find(params[:id])
      if @task.update_attributes(task_params)
        @job = Job.find(@task.job_id)
        current_user.wordCount = current_user.wordCount + (@task.source_text.length / 5)
        current_user.funds || current_user.funds = 0
        current_user.funds += @task.price
        current_user.save!
        job_completed = @job.tasks.none? { |task| task.status == 'in progress' }
        if job_completed
          @job.write_to_file
          @job.update_attributes(status: "completed")
          UserMailer.completed_job(current_user, @job).deliver
        end
        render json: @task
      else
        render json: ["major problems"], status: 403
      end
    end
    

    private

    def task_params
      params.require(:task).permit(:job_id, :source_text, :machine_text, :target_text, :translator_id, :source_lang, :target_lang, :status, :price)
    end
  end
end