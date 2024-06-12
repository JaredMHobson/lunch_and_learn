# Lunch and Learn

## Table of Contents
- [Getting Started](#getting-started)
- [Project Description](#project-description)
- [External APIs and Services](#external-apis-and-services)
- [End Points](#end-points)
- [Contributors](#contributors)

## Getting Started
### Versions
- Ruby: 3.2.2
- Rails: 7.1.3

## Project Description

Lunch and Learn exposes an API that allows you to search for cuisines by country, and to provide an opportunity to learn more about that country’s culture. This app will allow users to search for recipes by country, mark recipes as “favorite”, and learn more about a particular country.


<details>
  <summary>Learning Goals for Project</summary>

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Implement Basic Authentication
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc).
</details>

<details>
  <summary>Setup</summary>

  1. Fork and/or Clone this Repo from GitHub.
  2. In your terminal use `$ git clone <ssh or https path>`.
  3. Change into the cloned directory using `$ cd example`.
  4. Install the gem packages using `$ bundle install`.
  5. Database Migrations can be set up by running: 
  ``` bash 
  $ rails rake db:{drop,create,migrate,seed}
  ```
</details>

<details>
  <summary>External API Setup (IMPORTANT)</summary>

  1. Sign up for and get an api key for the [Edamam Recipe API](https://developer.edamam.com/edamam-recipe-api).
  2. Sign up for and get an api key for the [YouTube API](https://developers.google.com/youtube/v3/getting-started).
  3. Set up a project for the YouTube API if you haven't already and make sure the [YouTube Data API v3](https://console.cloud.google.com/apis/library/youtube.googleapis.com?project=lunch-and-learn-426023) is enabled.
  4. Sign up for and get an api key for the [Unsplash API](https://unsplash.com/developers)
  5. In your terminal in VS Code while in the directory for the application, run this `$ EDITOR="code --wait" rails credentials:edit`
  6. Add these API keys to the credentials.yml file that automatically pops up like so and then close the file. (You may need to delete the existing credentials file found at `config/credentials.yml`)
  ```
  edamam:
    key: <YOUR_EDAMAM_API_KEY>
    id: <YOUR_EDAMAM_APP_ID>

  youtube:
    key: <YOUR_YOUTUBE_API_KEY>

  unsplash:
    key: <YOUR UNSPLASH API KEY>
  ```
</details>

<details>
  <summary>Testing</summary>

  Test using the terminal utilizing RSpec:

  ```bash
  $ bundle exec rspec spec/<follow directory path to test specific files>
  ```

  or test the whole suite with `$ bundle exec rspec`

</details>

<details>
  <summary>Database Schema</summary>
  
```
ActiveRecord::Schema[7.1].define(version: 2024_06_11_192136) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.string "country"
    t.string "recipe_link"
    t.string "recipe_title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "api_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favorites", "users"
end
```
</details>

## External APIs and Services
#### Edamam Recipe API
  - Utilized to provide recipes relevant to the searched country. 

  - [Edamam Recipe API Documentation](https://developer.edamam.com/edamam-docs-recipe-api)

#### YouTube API Search Lists Endpoint
  - Utilized to provide links to educational videos as a learning resource about a searched country. Pulls videos from the YouTube channel [Mr. History YouTube Channel](https://www.youtube.com/channel/UCluQ5yInbeAkkeCndNnUhpw)

  - [YouTube API Search Lists Documentation](https://developers.google.com/youtube/v3/docs/search/list)

#### Unsplash API
  - Utilized to provide images as a learning resource about a searched country. 

  - [Unsplash API Documentation](https://unsplash.com/documentation)

## End Points
<details>
<summary> Get Recipes For A Particular Country </summary>

Request:

```http
GET /api/v1/recipes?country=thailand
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Sriracha",
                "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/."
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```
</details>

<details>
<summary> Get Learning Resources for a Particular Country </summary>

Request:

```http
GET /api/v1/learning_resources?country=laos
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "standing statue and temples landmark during daytime",
                    "url": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "five brown wooden boats",
                    "url": "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwyfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "orange temples during daytime",
                    "url": "https://images.unsplash.com/photo-1563492065599-3520f775eeed?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwzfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {...},
                {...},
                {...},
                {etc},
              ]
        }
    }
}
```
</details>

<details>
<summary> User Registration </summary>

Request:

```http
POST /api/v1/users
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  "name": "Odell",
  "email": "goodboy@ruffruff.com",
  "password": "treats4lyf",
  "password_confirmation": "treats4lyf"
}
```

Response: `status: 201`

```json
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
</details>

<details>
<summary> Log In User </summary>

Request:

```http
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
  "email": "goodboy@ruffruff.com",
  "password": "treats4lyf"
}
```

Response: `status: 200`

```json
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
</details>

<details>
<summary> Add Favorites </summary>

Request:

```http
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json
```

Body: 

```json
{
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```

Response: `status: 201`

```json
{
    "success": "Favorite added successfully"
}
```
</details>

<details>
<summary> Get a User’s Favorites </summary>

Request:

```http
GET /api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Recipe: Egyptian Tomato Soup",
                "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                "country": "egypt",
                "created_at": "2022-11-02T02:17:54.111Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                "recipe_link": "https://www.tastingtable.com/.....",
                "country": "thailand",
                "created_at": "2022-11-07T03:44:08.917Z"
            }
        }
    ]
 }   
```
</details>

## Contributors
* Jared Hobson | [GitHub](https://github.com/JaredMHobson) | [LinkedIn](https://www.linkedin.com/in/jaredhobson/)
