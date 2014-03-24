Sen-Proj
========


Intercollege Education Portal for professor and student.
To run this you will need mysql2 

Tasks on the ways (rake notes)

app/controllers/comments_controller.rb:
  * [ 4] [TODO] Check Authentication while crud
  * [28] [TODO] use function
  * [39] [TODO] Modularized functions DRY Code

app/controllers/main_controller.rb:
  * [ 6] [FIXME] Check header's nav bar on corresponding erb

app/controllers/posts_controller.rb:
  * [ 4] [TODO] Check Authentication while crud
  * [13] [FIXME] Added option to save tags and tag
  * [31] [TODO] Edit a post
  * [35] [TODO] Delete a post

app/controllers/users_controller.rb:
  * [ 3] [TODO] make sure user does not register with reserved keyword
  * [ 4] [TODO] Validation for profile form
  * [10] [TODO] 404 pages here
  * [14] [TODO] Show his details
  * [19] [TODO] 404 pages here
  * [22] [TODO] Show his details
  * [38] [TODO] Check validation
  * [39] [FIXME] Dry
  * [84] [TODO] Implement a proper page
  * [91] [TODO] Profile page for professor
  * [94] [TODO] Profile page for ambassador

app/models/user.rb:
  * [24] [FIXME] link to student or professor

