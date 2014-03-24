Sen-Proj
========


Intercollege Education Portal for professor and student.
To run this you will need mysql2 

Tasks on the ways (rake notes)
app/controllers/comment_controller.rb:
  * [ 4] [TODO] Check Authentication while crud
    * [28] [TODO] use function
      * [39] [TODO] Modularized functions DRY Code

      app/controllers/main_controller.rb:
        * [ 6] [FIXME] Check header's nav bar on corresponding erb

        app/controllers/post_controller.rb:
          * [ 4] [TODO] Check Authentication while crud
            * [13] [FIXME] Added option to save tags and tag
              * [31] [TODO] Edit a post
                * [35] [TODO] Delete a post

                app/controllers/user_controller.rb:
                  * [ 2] [TODO] make sure user does not register with reserved keyword
                    * [ 3] [TODO] Validation for profile form
                      * [ 9] [TODO] 404 pages here
                        * [12] [TODO] Show his details
                          * [16] [TODO] Profile page for professor
                            * [18] [TODO] Profile page for ambassador
                              * [24] [TODO] 404 pages here
                                * [27] [TODO] Show his details
                                  * [42] [TODO] Check validation
                                    * [43] [FIXME] Dry

                                    app/models/user.rb:
                                      * [24] [FIXME] link to student or professor

