
module Api
  class TasksController < ApiController
    def create
      @task = Task.new(task_params)
      @task.save
    end

    def index
      @tasks = Task.all
      if (params['source_lang'] && params['target_lang'])
        @tasks = @tasks.where(source_lang: params['source_lang'], target_lang: params['target_lang'])
      end
      if (params['status'])
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
      debugger
      if @task.update_attributes(task_params)
        @job = Job.find(@task.job_id)
        job_completed = @job.tasks.none? { |task| task.status == 'in progress' }
        if job_completed
          @job.write_to_file
          @job.status = 'completed'
          @job.save!
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

# class CatsController
#   def index
#     @cats = Cat.all
#     @cats = @cats.where(coat_color: params[:coat_color]) if params[:coat_color]
#     @cats = @cats.where(cuddly: params[:cuddly]) if params[:cuddly]