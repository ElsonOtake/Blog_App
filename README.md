<a name="readme-top"></a>

<!-- TABLE OF CONTENTS -->

# 📗 Table of Contents

- [📖 About the Project](#about-project)
  - [🛠 Built With](#built-with)
    - [Tech Stack](#tech-stack)
    - [Key Features](#key-features)
  - [🚀 Live Demo](#live-demo)
- [💻 Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
  - [Install](#install)
  - [Usage](#usage)
  - [Run tests](#run-tests)
- [👥 Authors](#authors)
- [🔭 Future Features](#future-features)
- [🤝 Contributing](#contributing)
- [⭐️ Show your support](#support)
- [🙏 Acknowledgements](#acknowledgements)
- [📝 License](#license)

<!-- PROJECT DESCRIPTION -->

# 📖 Blog <a name="about-project"></a>

**Blog** is a classic example of a blog website. That show the list of posts and empower readers to interact with them by adding comments and liking posts. This is the used [data model](./lib/assets/blog_app_erd.png).


## 🛠 Built With <a name="built-with"></a>

### Tech Stack <a name="tech-stack"></a>

<details>
  <summary>Client</summary>
  <ul>
    <li><a href="https://rubyonrails.org/">Ruby on Rails</a></li>
  </ul>
</details>

<details>
  <summary>Server</summary>
  <ul>
    <li><a href="https://github.com/igorkasyanchuk/active_storage_validations">Active Storage Validation</a></li>
    <li><a href="https://github.com/fnando/browser">Browser</a></li>
    <li><a href="https://github.com/flyerhzm/bullet">Bullet</a></li>
    <li><a href="https://bulma.io/">Bulma</a></li>
    <li><a href="https://github.com/CanCanCommunity/cancancan">Cancancan</a></li>
    <li><a href="https://github.com/teamcapybara/capybara">Capybara</a></li>
    <li><a href="https://github.com/ankane/chartkick">Chartkick</a></li>
    <li><a href="https://rubygems.org/gems/devise/">Devise</a></li>
    <li><a href="https://github.com/thoughtbot/factory_bot">Factory Bot</a></li>
    <li><a href="https://github.com/faker-ruby/faker">Faker</a></li>
    <li><a href="https://github.com/norman/friendly_id">FriendlyId</a></li>
    <li><a href="https://jwt.io/">JWT</a></li>
    <li><a href="https://github.com/cookpad/omniauth-rails_csrf_protection">OmniAuth Rails CSRF Protection</a></li>
    <li><a href="https://github.com/omniauth/omniauth-github">OmniAuth GitHub</a></li>
    <li><a href="https://github.com/zquestz/omniauth-google-oauth2">OmniAuth Google OAuth2</a></li>
    <li><a href="https://github.com/ddnexus/pagy">Pagy</a></li>
    <li><a href="https://github.com/rspec/rspec-rails">RSpec Rails</a></li>
    <li><a href="https://github.com/rubocop/rubocop">Rubocop</a></li>
    <li><a href="https://stimulus.hotwired.dev/">Stimulus</a></li>
    <li><a href="https://github.com/hotwired/turbo-rails">Turbo Rails</a></li>
  </ul>
</details>

<details>
<summary>Database</summary>
  <ul>
    <li><a href="https://www.postgresql.org/">PostgreSQL</a></li>
    <li><a href="https://www.elephantsql.com/">ElephantSQL</a></li>
  </ul>
</details>

<!-- Features -->

### Key Features <a name="key-features"></a>

- **REST API**
- **Omniauth**
- **[API documentation](https://swagger.io/solutions/api-documentation/)**
- **Real time update analytic charts**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LIVE DEMO -->

## 🚀 Live Demo <a name="live-demo"></a>

- [Render](https://elsonotake-blog.onrender.com/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## 💻 Getting Started <a name="getting-started"></a>

To get a local copy up and running, follow these steps.

### Prerequisites

In order to run this project you need:

[Ruby](https://www.ruby-lang.org/en/)

### Setup

Clone this repository to your desired folder:

using HTTPS:
```sh
  git clone https://github.com/ElsonOtake/Blog_App.git
  cd Blog_App
```

using an SSH key:
```sh
  git clone git@github.com:ElsonOtake/Blog_App.git
  cd Blog_App
```

using GitHub CLI:
```sh
  git clone gh repo clone ElsonOtake/Blog_App
  cd Blog_App
```

### Install

Fill in the environment variables
```sh
  DATABASE_DEV_USERNAME=postgres_username
  DATABASE_DEV_PASSWORD=postgres_password
  GITHUB_ID=github_client_id
  GITHUB_SECRET=github_client_secret
  GOOGLE_ID=google_client_id
  GOOGLE_SECRET=google_secret_key
```

Install this project with:
```sh
  bundle install
  rails db:create db:migrate db:seed
```

### Usage

To run the project, execute the following command:

```sh
  bin/dev
```
Open `http://localhost:3000/` on your browser.

### Run tests

To run tests, run the following command:

```sh
  bundle exec rspec spec/features
  bundle exec rspec spec/models
  bundle exec rspec spec/requests
  rails test test/models
  rails test test/controllers
  rails test test/integration
  rails test test/system
```

To generate the API documentation:
```sh
  bundle exec rake rswag
```
[API documentation](http://localhost:3000/api-docs/index.html) address.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- AUTHORS -->

## 👥 Authors <a name="authors"></a>

👤 **Elson Otake**

- GitHub: [elsonotake](https://github.com/elsonotake)
- Twitter: [@elsonotake](https://twitter.com/elsonotake)
- LinkedIn: [elsonotake](https://linkedin.com/in/elsonotake)

👤 **Jesús Vázquez**

- GitHub: [@jevazquezb](https://github.com/jevazquezb)
- Twitter: [@javb_1187](https://twitter.com/javb_1187)
- LinkedIn: [@jevazquezb](https://www.linkedin.com/in/jevazquezb)

👤 **Addisu Haile**

- GitHub: [@Addisu87](https://github.com/Addisu87)
- Twitter: [@AddisuTedla](https://twitter.com/AddisuTedla)
- LinkedIn: [Addisu Tedla](www.linkedin.com/in/addisu-tedla/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- FUTURE FEATURES -->

## 🔭 Future Features <a name="future-features"></a>

- [ ] **Add new features to API documentation**

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## 🤝 Contributing <a name="contributing"></a>

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- SUPPORT -->

## ⭐️ Show your support <a name="support"></a>

Give a ⭐️ if you like this project!

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGEMENTS -->

## 🙏 Acknowledgments <a name="acknowledgements"></a>

I would like to thank:

- [Microverse](https://www.microverse.org/)
- [W3Schools](https://www.w3schools.com/)
- [Stack Overflow](https://stackoverflow.com/)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## 📝 License <a name="license"></a>

This project is [MIT](./MIT.md) licensed.

<p align="right">(<a href="#readme-top">back to top</a>)</p>
