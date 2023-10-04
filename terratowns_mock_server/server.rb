require 'sinatra'
require 'json'
require 'pry'
require 'active_model'

# The below variable is a Global Variables (as this is a ruby file)
# We will mock have a state or database for this development server by setting this variable this way.
# You would NEVER use a global variable in a production server !!!
$home = {}

# This is a ruby class that includes validations from ActiveRecord.
# This will represent our home resource as a ruby object.
class Home
  # ActiveModel is part of Ruby-On-Rails.
  # It is used as an ORM. It has a module within ActiveModule that provides validation.
  # The production Terratowns server is rails and uses very similar and in most cases identical validation.
  # https://guides.rubyonrails.org/active_record_basics.html
  # https://guides.rubyonrails.org/active_model_basics.html
  # https://guides.rubyonrails.org/active_record_validations.html
  include ActiveModel::Validations

  # Create some virtual attributes to be stored on this object.
  # This will set a "getter" and "setter".
  # eg.
  # home = new Home()
  # home.town = 'hello' # setter
  # home.town() # getter
  attr_accessor :town, :name, :description, :domain_name, :content_version

  validates :town, presence: true, inclusion: { in: [
    'cooker-cove',
    'gamers-grotto',
    'video-valley',
    'the-nomad-pad',
    'melomanic-mansion'
  ] }
  # This is Visible to all users
  validates :name, presence: true
    # This is Visible to all users
  validates :description, presence: true
    # This needs to be locked to be only fromt CloudFront
  validates :domain_name, 
    format: { with: /\.cloudfront\.net\z/, message: "domain must be from .cloudfront.net" }
    # uniqueness: true, 

  # Content Version HAS to be an integer.
  # We will make sure it is a incremental in the controller.
  validates :content_version, numericality: { only_integer: true }
end

# We are extending a class from Sinatra::Base to utilize the Sinatra web-framwork.
class TerraTownsMockServer < Sinatra::Base

  def error code, message
    halt code, {'Content-Type' => 'application/json'}, {err: message}.to_json
  end

  def error_json json
    halt code, {'Content-Type' => 'application/json'}, json
  end

  def ensure_correct_headings
    unless request.env["CONTENT_TYPE"] == "application/json"
      error 415, "expected Content_type header to be application/json"
    end

    unless request.env["HTTP_ACCEPT"] == "application/json"
      error 406, "expected Accept header to be application/json"
    end
  end

  # Returning an access token
  def x_access_code
    '9b49b3fb-b8e9-483c-b703-97ba88eef8e0'
  end

  def x_user_uuid
    'e328f4ab-b99f-421c-84c9-4ccea042c7d1'
  end

  def find_user_by_bearer_token
    # https://swagger.io/docs/specification/authentication/bearer-authentication/
    auth_header = request.env["HTTP_AUTHORIZATION"]
    # Check if the authorization header exists
    if auth_header.nil? || !auth_header.start_with?("Bearer ")
      error 401, "a1000 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # Does the token match the one in our database? code = access_code = token - all the same
    # If we can't find it / if it doesn't match - return error
    code = auth_header.split("Bearer ")[1]
    if code != x_access_code
      error 401, "a1001 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # Was there a user_uuid in the body payload json?
    if params['user_uuid'].nil?
      error 401, "a1002 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    # The code and user_uuid should be matching for this user
    # In rails: User.find_by access_code: code, user_uuid: user_uuid
    unless code == x_access_code && params['user_uuid'] == x_user_uuid
      error 401, "a1003 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
  end

  # CREATE
  post '/api/u/:user_uuid/homes' do
    ensure_correct_headings #function
    find_user_by_bearer_token #function
    # puts will print to the terminal
    puts "# create - POST /api/homes"

    # A begin/resue is a try/catch
    begin
      # Sinatra does not automatically parse json bodies as params like rails, so we need to manually parse it.
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data.
    # Assign the payload to variables to make it easier to work with the code.
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]
    town = payload["town"]

    # Printing the variables out to the console to see or debug what has been input into the endpoint.
    puts "name #{name}"
    puts "description #{description}"
    puts "domain_name #{domain_name}"
    puts "content_version #{content_version}"
    puts "town #{town}"

    # Create a new Home model and set the attributes
    home = Home.new
    home.town = town
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version
    
    # Ensure our validation checks pass, otherwise return error messages as json.
    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    # Generating a uuid at random
    uuid = SecureRandom.uuid
    puts "uuid #{uuid}"
    # Will mock our data to our mock database which is just a global variable
    $home = {
      uuid: uuid,
      name: name,
      town: town,
      description: description,
      domain_name: domain_name,
      content_version: content_version
    }

    # Will return a uuid
    return { uuid: uuid }.to_json
  end

  # READ
  get '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# read - GET /api/homes/:uuid"

    # checks for house limit

    content_type :json
    # Does the uuid for the home match the one in our database?
    if params[:uuid] == $home[:uuid]
      return $home.to_json
    else
      error 404, "failed to find home with provided uuid and bearer token"
    end
  end

  # UPDATE
  # Very similar to our create action
  put '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# update - PUT /api/homes/:uuid"
    begin
      # Parse JSON payload from the request body
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]

    unless params[:uuid] == $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    home = Home.new
    home.town = $home[:town]
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version

    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    return { uuid: params[:uuid] }.to_json
  end

  # DELETE
  delete '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# delete - DELETE /api/homes/:uuid"
    content_type :json

    if params[:uuid] != $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    $home = {}
    { message: "House deleted successfully" }.to_json
  end
end

# This is what will run the server.
TerraTownsMockServer.run!