require "prawn"
module Api
  class JobsController < ApiController
    def create
      @job = current_user.jobs.new(job_params)
      #Check to make sure the user has enough money in their account.
      #subtract the price of the job from the users account.
      if @job.email.blank?
        @job.email = current_user.email
      end
      
      if @job.save
        #@job.delay.print
        
        Job.build_and_translate(@job.id)
        current_user.funds || current_user.funds = 0
        current_user.funds -= @job.price
        current_user.words_purchased += (@job.source_text.length / 4.5)
        current_user.save!
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
      # Add in current user
      @jobs = current_user.jobs
      render json: @jobs
    end

    def show
      @job = Job.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
          pdf = JobPdf.new(@job)
          send_data pdf.render(@job),
          filename: "#{@job.title}_#{@job.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
        end
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
      :status, :price, :translated_file, :email)
    end
  end
end
