# Advertise app application

This app was created as part of the junior ruby on rails test task that I received from one company, you can checkout below
[*Task description(only in russian)*](https://1drv.ms/b/s!As14WhAEuBSil3n29oKO87wTTzxu?e=0fhtAA).

## Information

I used postgres database for development, to do all necessary installation faster I deployed my database to Docker container, then I started to work on the user model.
By the task requirements I should have done basis authentication for a user(email,login,change password) and avatar support, so I did that using Devise gem,
then I added advert model(title, content, picture, address, status), I used carrierwave for picture uploading(and users avatars too), and fog gem for production(aws s3-bucket),
also I address to advert model, to fill address form on advert creation I added GoogleMaps API to my application. I used has_many belongs_to association between user
and adverts. According to the task every advert should have a tag(name), tags itself should have a unique name, I decided to make a restriction on number of tags
allowed upon creation(6), then I added admin to user, and made a restriction that only admin can create and edit tags(also admin can delete other user and their adverts)
Advert and Tags connected via has_many through association. Last model was comment(content), I added comments functionality to view with ajax, basically create and edit actions.
Finally search functionality for adverts, users can find adverts by title, content words, address, tags, author. For styling I used bootstrap.

Checkout the app on heroku [Advertise app](https://junior-test-task.herokuapp.com/)

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

Also you can seed database

```
$ rails db:seed
```

Then 

```
$ rails server
```

For more information, feel free to ask me.
