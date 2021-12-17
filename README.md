# Task Rocket API

Task Rocket is a Full-Stack Web Application. This is the repository for the backend task_rocket_api. The frontend repository can be found [here](https://github.com/anikajb92/task-rocket-app).


## Ruby version

ruby 2.6.6

## Technologies

* Ruby on Rails
* Active Record

## Database and System dependencies

* PostgreSQL
* This API also utilizes rack-cors, JSON web tokens, Bcrypt, and Pry

## Launch
* Initialize DB 
* Run rails server `rails s`
* In order to use the full app, open and run the [frontend repo](https://github.com/anikajb92/task-rocket-app)

## Code Examples

 Class Method I created to track a user's 'most productive day' based on the day of the week that most tasks are completed on.

```ruby
def most_productive_day
    all_completed = self.tasks.where(completed: true)

    completed_weekday = all_completed.map do |task|
      finish_date = task.updated_at.strftime("%A")
    end.group_by(&:itself).transform_values(&:count) # returns hash with "Day"=>tally pairs for each day of the week

    arr = completed_weekday.sort_by { |k , v| v }.reverse #returns array with [Day, value] pairs sorted by highest value first
    
    arr.first #returns first hash in the first pair in the array
  end
```
This method is built in the application controller to authorize login and protect routes.

```ruby
def authenticate
    auth_header = request.headers[:Authorization]
    if !auth_header
      render json: {error: 'Auth bearer token header is required'}, status: :forbidden
    else 
      token = auth_header.split(' ')[1]
      secret = '*#*#*' #enter protected secret here
      begin
        decoded_token = JWT.decode token, secret
        payload = decoded_token.first
        @user = User.find payload['user_id'] #instance variable that can be carried across methods
      rescue 
        render json: {error: 'Unrecognized auth bearer token'}, status: :forbidden
      end
    end 
  end
```