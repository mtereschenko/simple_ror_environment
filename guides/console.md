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

* This command runs the actually the app. 
  ```bash
  make run
  ```

* This command "teleports" you to the command shell where you can execute **node**, **npm**, **ng**, etc. commands.
  ```bash
  make shell
  ```

To run angular server run  **make run** or **make shell** then **ng serve --host 0.0.0.0 --disable-host-check**

After that your project will be able to visit by `http://${PROJECT_NAME}.localhost`. By default, it's `http://test_project.localhost`.
