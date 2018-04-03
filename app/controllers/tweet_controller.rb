class TweetController < ApplicationController
  
  get "/tweets" do
    if !logged_in? then redirect "/"
    else erb :"tweet/index"
    end
  end

  get "/tweets/new" do
    if !logged_in? then redirect "/"
    else erb :"tweet/new"
    end
  end
  
  post "/tweets" do
    tweet = current_user.tweets.build({:content => params["content"]})
    if !!tweet.save then redirect "/tweets/#{tweet.id}"
    else redirect "/tweets/new"
    end
  end
  
  get "/tweets/:id" do
    if !logged_in? then redirect "/"
    else
      @tweet = Tweet.find_by(:id => params["id"])
      if current_user.id == @tweet.user.id then erb :"tweet/show"
      else redirect "/tweets"
      end
    end
  end
  
  get "/tweets/:id/edit" do
    if !logged_in? then redirect "/"
    else
      @tweet = Tweet.find_by(:id => params["id"])
      if current_user.id == @tweet.user.id then erb :"tweet/edit"
      else redirect "/tweets"
      end
    end
  end
  
  patch "/tweets/:id" do
    tweet = Tweet.find_by(:id => params["id"])
    if current_user.id == tweet.user.id
      Tweet.update(tweet.id, {:content => params["content"]})
    end
    redirect "/tweets/#{tweet.id}"
  end
  
  delete "/tweets/:id/delete" do
    tweet = Tweet.find_by(:id => params["id"])
    tweet.destroy if current_user.id == tweet.user.id
    redirect "/tweets"
  end
  
end