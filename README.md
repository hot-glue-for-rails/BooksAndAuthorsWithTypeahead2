Example app for Hot Glue 0.6.0
Here's how this app was built:
```
bin/rails generate model Author first_name:string last_name:string
bin/rails generate model Book author_id:integer title:string
```
next, install the global typeahead tools
`bin/rails generate hot_glue:typeahead_install`

next, generate a scaffold for the authors
`bin/rails generate hot_glue:scaffold Author --gd --smart-layout`

next, generate a scaffold for the books and modify the author_id into a type ahead:
`bin/rails generate hot_glue:scaffold Book --modify='author_id{typeahead}' --gd --smart-layout`


Notice this gives us an important warning message:
```
WARNING: you specified --modify=author_id{typeahead} but there is no file at `app/controllers/authors_typeahead_controller.rb`
```
It instructs us to do this:

`bin/rails generate hot_glue:typeahead Author`



As well as the above, I created methods `name` on both Book and Author, and added to the config/routes.rb file


# Setup

You do not do the steps above, they are just written out to demonstrate what I did to build the app. 

After you db:create & db:migrate, you should seed this database using the data migrator:

`bin/rails data:migrate`
this will create 100 random author names and 1000 random books.


Node + Ruby versions are in `.node-version` and `.ruby-version`, respectively.



`bin/setup`

# Start Rails

`bin/dev`

# Run Specs

run with `bin/rake`
