class SessionsController < ApplicationController
  def new

  end

  def create

    #hae annettua usernamea vastaava käyttäjä kannasta
    user = User.find_by username: params[:username]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Welcome back!"
    else
      redirect_to :back, notice: "Invalid username or password!"
    end
  end

  def destroy

    #nollataan sessio
    session[:user_id] = nil
    #takaisin aloitussivulle
    redirect_to :root

  end
end
