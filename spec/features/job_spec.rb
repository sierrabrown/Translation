require 'spec_helper'
feature "job creation" do

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

feature 'job processing' do
  
  before :each do
    @job = Job.create({title: "As Data Overflows Online, Researchers Grapple With Ethics", 
                      source_text: "Fanny pack wayfarers fashion axe vegan fingerstache. Flexitarian street art roof party, lomo salvia asymmetrical post-ironic seitan cornhole. Sustainable pork belly Portland flexitarian DIY 8-bit, Truffaut chillwave umami street art wayfarers try-hard Vice. Fingerstache lo-fi scenester, freegan ethnic selfies Wes Anderson dreamcatcher bicycle rights cornhole. Salvia flannel Truffaut Austin master cleanse, 8-bit kogi cliche Williamsburg Wes Anderson swag ugh Echo Park beard. Chillwave squid paleo vinyl keytar. Keffiyeh flannel sriracha, gentrify bitters sustainable mustache retro synth cred.

                      sartorial Etsy church-key, sriracha single-origin coffee forage Portland scenester. Craft beer Wes Anderson tofu YOLO, fingerstache trust fund keytar gentrify Helvetica photo booth 8-bit Williamsburg. Single-origin coffee banh mi dreamcatcher salvia hashtag, Tonx literally drinking vinegar. DIY aesthetic locavore authentic, pug leggings Odd Future skateboard Vice. Next level organic PBR&B Truffaut, readymade brunch aesthetic roof party McSweeney's master cleanse pickled swag normcore disrupt. 8-bit kogi swag salvia, ethnic Vice umami before they sold out organic jean shorts brunch drinking vinegar Blue Bottle narwhal. Normcore shabby chic bicycle rights, synth mixtape deep v freegan food truck occupy Cosby sweater viral.
                      
                      ger bag. Trust fund bespoke selvage, banh mi skateboard High Life kitsch. Blue Bottle Godard semiotics ennui, Pinterest stumptown banh mi art party Portland Banksy. Biodiesel Vice ethnic brunch. Actually ennui Thundercats sartorial mustache. Intelligentsia mustache roof party street art. Kogi ethical cardigan semiotics, farm-to-table cray Truffaut sustainable Intelligentsia Portland Tonx brunch Tumblr pickled.
                      
                      semiotics gastropub organic sriracha chia. Keytar meggings cliche, 8-bit Etsy you probably haven't heard of them paleo drinking vinegar cred pug stumptown. Synth Portland food truck, art party bitters fap scenester roof party hella hashtag Kickstarter. IPhone try-hard mixtape gluten-free fanny pack dreamcatcher. Leggings crucifix fixie Wes Anderson, gluten-free umami sustainable irony before they sold out quinoa VHS. Disrupt viral sustainable Brooklyn Vice yr Bushwick cliche 90's fixie four loko. High Life Austin banh mi church-key Helvetica.", 
                      machine_text: "Fanny pack wayfarers fashion axe vegan fingerstache. Flexitarian street art roof party, lomo salvia asymmetrical post-ironic seitan cornhole. Sustainable pork belly Portland flexitarian DIY 8-bit, Truffaut chillwave umami street art wayfarers try-hard Vice. Fingerstache lo-fi scenester, freegan ethnic selfies Wes Anderson dreamcatcher bicycle rights cornhole. Salvia flannel Truffaut Austin master cleanse, 8-bit kogi cliche Williamsburg Wes Anderson swag ugh Echo Park beard. Chillwave squid paleo vinyl keytar. Keffiyeh flannel sriracha, gentrify bitters sustainable mustache retro synth cred.

                      Lo-fi crucifix stumptown vegan tousled wolf sartorial Etsy church-key, sriracha single-origin coffee forage Portland scenester. Craft beer Wes Anderson tofu YOLO, fingerstache trust fund keytar gentrify Helvetica photo booth 8-bit Williamsburg. Single-origin coffee banh mi dreamcatcher salvia hashtag, Tonx literally drinking vinegar. DIY aesthetic locavore authentic, pug leggings Odd Future skateboard Vice. Next level organic PBR&B Truffaut, readymade brunch aesthetic roof party McSweeney's master cleanse pickled swag normcore disrupt. 8-bit kogi swag salvia, ethnic Vice umami before they sold out organic jean shorts brunch drinking vinegar Blue Bottle narwhal. Normcore shabby chic bicycle rights, synth mixtape deep v freegan food truck occupy Cosby sweater viral.

                      Gluten-free Carles small batch Neutra messenger bag. Trust fund bespoke selvage, banh mi skateboard High Life kitsch. Blue Bottle Godard semiotics ennui, Pinterest stumptown banh mi art party Portland Banksy. Biodiesel Vice ethnic brunch. Actually ennui Thundercats sartorial mustache. Intelligentsia mustache roof party street art. Kogi ethical cardigan semiotics, farm-to-table cray Truffaut sustainable Intelligentsia Portland Tonx brunch Tumblr pickled.

                      Shabby chic ethnic cardigan, synth tote bag semiotics gastropub organic sriracha chia. Keytar meggings cliche, 8-bit Etsy you probably haven't heard of them paleo drinking vinegar cred pug stumptown. Synth Portland food truck, art party bitters fap scenester roof party hella hashtag Kickstarter. IPhone try-hard mixtape gluten-free fanny pack dreamcatcher. Leggings crucifix fixie Wes Anderson, gluten-free umami sustainable irony before they sold out quinoa VHS. Disrupt viral sustainable Brooklyn Vice yr Bushwick cliche 90's fixie four loko. High Life Austin banh mi church-key Helvetica.", 
                      source_lang: "en", 
                      target_lang: "es"})
  end
  it "will be split up into small text segments" do
    source_texts = Job.split_text(@job.source_text)
    expect(source_texts.length).to eq(5)
  end
  
  it "create task objects" do
    source_texts = Job.split_text(@job.source_text)
    @job.create_tasks(source_texts, source_texts)
    expect(@job.tasks.length).to eq(5)
  end

end