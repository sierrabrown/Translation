require 'spec_helper'
feature "task" do

  it "can be built using correct parameters" do
      Task.create({source_text: "task source text", machine_text: "texto original", source_lang: "en", target_lang: "es"}).should be_valid
  end
  
  it "validates source text presence" do
      Task.create({source_lang: "en", machine_text: "texto original", target_lang: "es"}).should_not be_valid
  end
  
  it "validates machine text presence" do
      Task.create({source_lang: "en", machine_text: "texto original", target_lang: "es"}).should_not be_valid
  end
  
  it "validates source and target languages are different" do
      Task.create({source_text: "test source text", source_lang: "en", target_lang: "en"}).should_not be_valid
  end
end
