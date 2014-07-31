ActionMailer::Base.smtp_settings = {
  :address    => "smtp.sendgrid.net",
  :port       => 587,
  :domain     => "translator.herokuapp.com",
  :username   => "sierrabrownsf@gmail.com",
  :password   => "1alzuaz1",
  :authentication => "plain"
}