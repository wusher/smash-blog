## features: 

# setup rspec 
# convert app to haml
# create a basic page home page
# deploy on heroku 
# add admin user/set up devise
# create a post model:
# # slugify title 
# # parse markdown 
# # parse code 
# create basic post views
# # index 
# # details 
# add about me
# make layout pretty 
# only display published 
# add sitemap
* create a post:
  # normal post
  # add admin nav
  ~ edit 
  * delete 
  * add security
  * add better error handling
* add pagination and an overview 
* add tags 
* add other posts types
  * quote post
  * link post 
  * code 



## post model 

* title 
* slug
* body
* body_html
* pubdate
* is published 


normal: 

  
quote:
  source
  link

code: 
  code
