require 'addressable/uri'

class Job < ActiveRecord::Base
  validates :title, :source_lang, :target_lang, presence: true
  
  has_many :tasks
  
  belongs_to :customer, foreign_key: :customer_id, class_name: "User"
  
  def print
    p "delayed jobs worked"
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
  
  def self.translateMultiple(task_source_texts, source_lang, target_lang) 
  
    translate_url = Addressable::URI.new(
    :scheme => 'https',
    :host => 'www.googleapis.com',
    :path => '/language/translate/v2',
    :query_values => {
      :key => 'AIzaSyBjBkoiAjrm1_rN_r_C-uxPrah8GJfvVkc',
      :target => target_lang,
      :source => source_lang,
      }
    ).to_s
    
    translate_url += build_query_string(task_source_texts)
    p translate_url
    
    translation = JSON.parse(RestClient.get(translate_url))
  
    target_texts_hash = translation["data"]["translations"]
  
    target_texts_arr = []
    target_texts_hash.each do |text|
      target_texts_arr << text["translatedText"]
    end
    target_texts_arr
  end
  
  def self.build_and_translate(id)
    job = Job.find(id)
    # Split job text into small tasks for translators
    source_texts = split_text(job.source_text)
    
    # Translate those texts in one mass call to google translate API
    machine_texts = translateMultiple(source_texts, job.source_lang, job.target_lang)
    # Add the machine translated version to the job object
    job.machine_text = machine_texts.join("")
    
    (0...source_texts.length).each do |task_num|
      job.tasks.new({source_text: source_texts[task_num], machine_text: machine_texts[task_num], source_lang: job.source_lang, target_lang: job.target_lang, completed: false})
    end 
    
    job.save! 
  end
end
