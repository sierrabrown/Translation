class JobPdf < Prawn::Document
  
  def initialize(job)
    super()
    @job = job
    text @job.title
    text @job.target_text
  end
  
  def render(job)
    doc = Prawn::Document.new
    doc.text job.title
    doc.text job.target_text
    doc.render
  end
end