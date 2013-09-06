## "Ruby Meets Clojure Flavored Database," BlendConf 2013 Slide

This repository has the slide application code I used at BlendConf 2013 presentation.
My slide app is a working example of JRuby on Rails, Datomic backend with Devise.
I used diametric gem for my slide app.

To run this app, follow the steps below:

1. Install JRuby 1.7.4

2. Get Datomic Free version 0.8.4122

    - Go to: http://downloads.datomic.com/free.html
    - Download datomic-free-0.8.4122.zip
    - Unzip the archive in some directory (anywhere)

3. Clone out my slide app for BlendConf 2013

    ```bash
    $ git clone git@github.com:yokolet/shamrock.blend.git
    ```

4. Run bundle install (make sure you are using JRuby!)

    ```bash
    $ cd shamrock.blend
    $ bundle install
    ```

5. Temporary rename diametric.yml to something else

    ```bash
    $ cd config
    $ mv diametric.yml diametric.yml.sample
    $ cd ..
   ```

6. Run migration for devise

    ```bash
    $ bundle install jruby -S rake db:migrate
    ````

7. Move back diametric.yml

    ```bash
    $ cd config
    $ mv diametric.yml.sample diametric.yml
    $ cd ..
    ```

8. Edit Datomic free transactor's configuration

    file: `shamrock.blend/vendor/config/free-transactor.properties`

    Edit the lines:
    ```java
    data-dir=<rails root>/vendor/db
    log-dir=<rails root>/vendor/log
    pid-dir=<rails root>/vendor/log/free-transactor.pid
    ```

    *<rails root> is a full path to shamrock.d including "shamrock.d"

9. Start Datomic free transactor

    `cd` to unzipped directory, then
    ```bash
    $ bin/transactor <rails root>/vendor/config//free-transactor.properties
    ```

10. Start Rails

    ```bash
    $ bundle exec jruby -S rails s
    ```

11. Go to http://localhost:3000/slideshow

    Right/Left arrows, buttons under the slide navigates you.


12. Go to http://localhost:3000/pages

    Devise authentication cuts in. So, sign up any email/password.   

    This is a slide editing page. Not very nice interface, but works.
    Try create new/edit/delete, and reload the slideshow.

13. Have fun

    If you have any comment or are having trouble to start the app,
    https://github.com/yokolet/shamrock.blend/issues/1
    is the place you go.