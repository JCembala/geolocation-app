# Geolocation API

This is a simple API that allows you to store geolocation data from a network address. <br>
It uses the [ipstack](https://ipstack.com/) API to get the geolocation data. <br>

The API has three endpoints:
* POST /geolocations
* GET /geolocations/:id
* DELETE /geolocations/:id

The `network_address` parameter can be either an IP address or a domain name. <br>

## Installation
In order to run the API you need to have Docker and Docker Compose installed. <br>

### Environment variables
After cloning the repository, run the following command:
```bash
cp .env.example .env
```
Then, you need to set the `IPSTACK_API_KEY` in the `.env` file with your ipstack API key. <br>

### Building and running the API
After that, you can run the following command to start the API:
```bash
docker compose up --build
```

### Creating the database
Next, you need to create the database and run the migrations:
```bash
docker compose exec web bundle exec rails db:create db:migrate
```
* How to run the test suite
```bash
docker compose exec web bundle exec rspec
```

## Usage
### Endpoints
#### Create a new geolocation record
- **URL:** `/geolocations`
- **Method:** `POST`
- **URL Params:** None
- **Data Params:** `{ network_address: 'ipstack.com' }`
- **Success Response:**
  - **Code:** 201
  - **Content:** `{ network_address: 'ipstack.com', response: <response_from_ipstack> }`
- **Error Response:**
  - **Code:** 422
  - **Content:** `{ errors: ['Network address is invalid'] }`
- **Sample Call:**
  ```bash
  curl -X POST -H "Content-Type: application/json" -d '{"network_address": "ipstack.com"}' http://localhost:3000/geolocations
  ```
#### Get a geolocation record
- **URL:** `/geolocations/:id`
- **Method:** `GET`
- **URL Params:** `id=[integer]`
- **Data Params:** None
- **Success Response:**
  - **Code:** 200
  - **Content:** `{ network_address: 'ipstack.com', response: <response_from_ipstack> }`
- **Error Response:**
  - **Code:** 404
  - **Content:** `{ errors: ['Record not found'] }`
- **Sample Call:**
  ```bash
  curl http://localhost:3000/geolocations/1
  ```
#### Delete a geolocation record
- **URL:** `/geolocations/:id`
- **Method:** `DELETE`
- **URL Params:** `id=[integer]`
- **Data Params:** None
- **Success Response:**
  - **Code:** 200
  - **Content:** `{ message: 'Successfully deleted geolocation' }`
- **Error Response:**
  - **Code:** 404
  - **Content:** `{ errors: ['Geolocation not found'] }`
- **Sample Call:**
  ```bash
  curl -X DELETE http://localhost:3000/geolocations/1
  ```
