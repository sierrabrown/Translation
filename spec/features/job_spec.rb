require 'spec_helper'
feature "job" do

  it "can be built using correct parameters" do
      Job.create({title: "test title", source_text: "test source text", source_lang: "en", target_lang: "es"}).should be_valid
  end

  it "validates title presence" do
      Job.create({source_text: "test source text", source_lang: "en", target_lang: "es"}).should_not be_valid
  end
  
  it "validates source text presence" do
      Job.create({title: "test source text", source_lang: "en", target_lang: "es"}).should_not be_valid
  end
  
  it "validates source and target languages are different" do
      Job.create({title: "test title", source_text: "test source text", source_lang: "en", target_lang: "en"}).should_not be_valid
  end
end
