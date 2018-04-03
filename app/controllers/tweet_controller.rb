class TweetController < ApplicationController
  
  get "/tweets" do
    if !logged_in? then redirect "/login"
    else erb :"tweet/index"
    end
  end

  get "/tweets/new" do
    if !logged_in? then redirect "/login"
    else erb :"tweet/new"
    end
  end
  
  post "/tweets" do
    if params["content"].strip.empty? then redirect "/tweets/new"
    else
      tweet = current_user.tweets.build({:content => params["content"]})
      if !!tweet.save then redirect "/tweets/#{tweet.id}"
      else redirect "/tweets/new"
      end
    end
  end
  
  get "/tweets/:id" do
    if !logged_in? then redirect "/login"
    else
      @tweet = Tweet.find_by(:id => params["id"])
      erb :"tweet/show"
    end
  end
  
  get "/tweets/:id/edit" do
    if !logged_in? then redirect "/login"
    else
      @tweet = Tweet.find_by(:id => params["id"])
      if !!@tweet && current_user.id == @tweet.user.id then erb :"tweet/edit"
      else redirect "/tweets"
      end
    end
  end
  
  patch "/tweets/:id" do
    tweet = Tweet.find_by(:id => params["id"])
    if !!tweet && current_user.id == tweet.user.id
      if params["content"].strip.empty?
        redirect "/tweets/#{tweet.id}/edit"
      else
        Tweet.update(tweet.id, {:content => params["content"]})
        redirect "/tweets/#{tweet.id}"
      end
    else redirect "/tweets"
    end
  end
  
  delete "/tweets/:id/delete" do
    tweet = Tweet.find_by(:id => params["id"])
    tweet.destroy if !!tweet && current_user.id == tweet.user.id
    redirect "/tweets"
  end
  
end