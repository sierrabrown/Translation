# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Job.create( 
title: "The Great Gatsby", 
description: "1925 novel by American author F.Scott Fitzgerald", 
source_text: "Then wear the gold hat, if that will move her.",
customer_id: 8,
source_lang_id: 1,
target_lang_id: 2,
completed: false,
price: 100
)

Job.create( 
title: "Currency Trading email", 
description: "General info", 
source_text: "Although forex is the largest financial market in the world.",
customer_id: 8,
source_lang_id: 1,
target_lang_id: 2,
completed: false,
price: 5
)

Job.create( 
title: "Currency Trading email number 2", 
description: "General info", 
source_text: "Although forex is the largest financial market in the world.",
customer_id: 9,
source_lang_id: 1,
target_lang_id: 2,
completed: false,
price: 5
)