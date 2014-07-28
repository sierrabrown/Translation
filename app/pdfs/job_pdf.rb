class JobPdf < Prawn::Document
  
  def initialize(job)
    super()
    @job = job
    text @job.title
    text @job.target_text
  end
end