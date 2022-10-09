## Console

* Open a new terminal window and CD to your projects directory
  ```bash
  cd ${PROJECT_PATH}/environment
  ```

* Use this command just once to initialize a new project.
  ```bash
  make init
  ```

* This command updates the environment or your Gemfile changes.
  ```bash
  make build
  ```

* This command runs the environment. 
  ```bash
  make start
  ```

* This command "teleports" you to the command shell where you can execute **rails**, **rake**, **bundle**, etc. commands.
  ```bash
  make shell
  ```

To run rails server run **make shell** then **bin/rails s -p 3000 --binding=0.0.0.0**

After that your project will be able to visit by `http://${PROJECT_NAME}.localhost`. By default, it's `http://test_project.localhost`.
