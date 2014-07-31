class UserMailer < ActionMailer::Base
  default from: "sierrabrown808@gmail.com"
  
  def completed_job(user, job)
    @job = job
    @user = user
    translation_pdf_view = JobPdf.new(@job)
    translation_pdf_content = translation_pdf_view.render(@job)
    
    #attachments["translation_#{@job.title}"] = {mime_type: 'application/pdf', content: translation_pdf_content}

    mail(to: @job.email, subject: "Your translated text #{@job.title} is attached.")
  end
end
