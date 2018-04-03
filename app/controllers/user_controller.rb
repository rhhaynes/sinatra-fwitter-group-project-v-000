class UserController < ApplicationController
  
  get "/" do
    if logged_in? then redirect "/tweets"
    else erb :"user/index"
    end
  end
  
  get "/signup" do
    if logged_in? then redirect "/tweets"
    else erb :"user/signup"
    end
  end
  
  post "/signup" do
    user = User.new(:username => params["username"],
                    :email    => params["email"],
                    :password => params["password"])
    if !!user.save
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/signup"
    end
  end
  
  get "/login" do
    if logged_in? then redirect "/tweets"
    else erb :"user/login"
    end
  end
  
  post "/login" do
    user = User.find_by(:username => params["username"])
    if !!user && !!user.authenticate(params["password"])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end
  
  get "/users/:slug" do
    @user = User.find_by_slug(params["slug"])
    if !!@user then erb :"user/show"
    else redirect "/tweets"
    end
  end
  
  get "/logout" do
    session.clear if logged_in?
    redirect "/login"
  end
  
end