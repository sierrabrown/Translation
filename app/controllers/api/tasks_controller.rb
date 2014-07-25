
module Api
  class TasksController < ApiController
    def create
      @task = Task.new(task_params)
      @task.save
    end

    def index
      @tasks = Task.all.where({source_lang: params['source_lang'], target_lang: params['target_lang']})
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
        render json: @task
      else
        render json: ["major problems"], status: 403
      end
    end


    private

    def task_params
      params.require(:task).permit(:job_id, :source_text, :machine_text, :target_text, :translator_id, :source_lang, :target_lang, :completed, :price)
    end
  end
end