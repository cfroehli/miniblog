# README

This is just a sandbox project used while learning ruby/rails. Do not trust this code too much...

# Notes about running system tests

  - selenium containers config in docker compose
    selenium-hub:
       image: selenium/hub:latest
       container_name: selenium-hub
       networks:
         selenium:
           aliases:
             - selenium-server
       ports:
         - 4444:4444
       environment:
         GRID_MAX_SESSION: 10

     selenium-chrome:
       image: selenium/node-chrome:latest
       depends_on:
         - selenium-hub
       networks:
         - selenium
       environment:
         HUB_HOST: selenium-hub
         NODE_MAX_INSTANCES: 10
         NODE_MAX_SESSION: 10

     selenium-chrome-standalone:
       image: selenium/standalone-chrome-debug:latest
       ports:
         - 4444:4444
         - 5900:5900
       networks:
         selenium:
           aliases:
             - selenium-server

   - single container with vncserver
     export USE_SELENIUM_CONTAINERS=Y
     edit application_system_test_case.rb => using: :chrome
     start the selenium-chrome-standalone container
     vncviewer {selenium-chrome-standalone ip}
     rails test:system

   - or with a workers pool
     export USE_SELENIUM_CONTAINERS=Y
     edit application_system_test_case.rb => driven_by using: :headless_chrome
     start the selenium-hub container
     start workers : up --scale selenium-chrome=4 selenium-chrome
     rails test:system

   - or local chrome
     unset USE_SELENIUM_CONTAINERS
     edit application_system_test_case.rb => driven_by using: :headless_chrome or :chrome
     rails test:system
