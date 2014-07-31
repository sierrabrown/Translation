class JobPdf < Prawn::Document
  
  def initialize(job)
    super()
    @job = job
    text @job.title
    text @job.target_text
  end
  
  def render(job)
    doc = Prawn::Document.new()
    doc.text "speakeasy  | translation + humanity | contact: sierra brown | sierrabrownsf@gmail.com", align: :center
    doc.text " "
    doc.text job.title, size: 25, style: :bold, align: :center
    doc.text " "
    
    doc.text "Translated from #{job.source_lang}:"
    doc.text job.source_text, final_gap: :true
    doc.text " "
    
    doc.text "Translated to #{job.target_lang}:"
    doc.text job.target_text
    doc.render
  end
end
