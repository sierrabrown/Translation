class JobPdf < Prawn::Document
  
  def initialize(job)
    super()
    @job = job
    text @job.title
    text @job.target_text
  end
  
  def render(job)
    doc = Prawn::Document.new()
    doc.text job.title, size: 30, style: :bold
    doc.text " "
    
    doc.text "Translated from #{job.source_lang}:"
    doc.text job.source_text, final_gap: :true
    doc.text " "
    
    doc.text "Translated to #{job.target_lang}:"
    doc.text job.target_text
    doc.render
  end
end
