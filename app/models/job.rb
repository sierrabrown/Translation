require 'addressable/uri'

class Job < ActiveRecord::Base
  
  has_attached_file :translated_file
  do_not_validate_attachment_file_type :translated_file
  include HTTParty
  validates :title, :source_lang, :target_lang, :source_text, presence: true
  validate :source_lang_does_not_equal_target_lang
  
  has_many :tasks
  
  belongs_to :customer, foreign_key: :customer_id, class_name: "User"
  
  def print
    p "delayed jobs worked"
  end
  
  def source_lang_does_not_equal_target_lang
    @errors.add(:base, "The source and target languages cannot be the same.") if self.target_lang == self.source_lang
  end
  
  def write_to_file
    target_text = ""
    self.tasks.each do |task|
      target_text = target_text + "\r\n" + task.target_text
    end
    self.target_text = target_text
  end
  
  def self.split_text(original)
    task_source_texts = []
  
    while (original.length >= 600)
      remainder = original[401..600]
      endpoint = (remainder.index('.') || remainder.index('!') || remainder.index(',') || 200) + 400
      task_source_texts << original[0..endpoint+1]
      original = original[endpoint+2..-1]
    
    end
  
    if original.length >=200
      task_source_texts << original
    else
      if task_source_texts.length == 0
        task_source_texts = [original]
      else
        task_source_texts[-1] = task_source_texts[0] + original
      end
    end
    return task_source_texts
  end
  
  def self.build_query_string(task_source_texts)
    query = ""
  
    task_source_texts.each do |text|
      query += "&q=" + text
    end
    query.gsub!(' ', '%20')
    query
  end
  
  def self.translateMultiple(task_source_texts, source, target)
    ToLang.start(ENV["google_translate_key"])
    array = []
    
    task_source_texts.each do |text|
      array << text.translate(target, :from => source)
    end
    return array
  end
  
  
  def create_tasks(source_texts, machine_texts)
    (0...source_texts.length).each do |task_num|
      self.tasks.new({
        source_text: source_texts[task_num], 
        machine_text: machine_texts[task_num], 
        source_lang: self.source_lang, 
        target_lang: self.target_lang, 
        status: 'in progress',
        price: (source_texts[task_num].length * 0.001).round(3) * 100
      })
    end
  end
  
  # The bulk of backend work moving the job from the customer to translators.
  def self.build_and_translate(id)
    job = Job.find(id)
    # Split job text into small tasks for translators
    source_texts = split_text(job.source_text)
    
    # Translate those texts in one mass call to google translate API
    machine_texts = translateMultiple(source_texts, job.source_lang, job.target_lang)
    # Add the machine translated version to the job object
    job.machine_text = machine_texts.join("")
    
    # Create tasks.
    job.create_tasks(source_texts, machine_texts)
    job.save! 
  end
  
end
