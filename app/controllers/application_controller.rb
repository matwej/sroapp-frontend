# -*- encoding : utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # nastavenie metod na protected, aby sa len dedili
  protected
  
  # metoda na autentifikaciu uzivatela
  def logged_in
    if session[:user_id]
    begin
      @logged_user = User.find session[:user_id]
    rescue Exception
      session[:user_id]=nil
      redirect_to(:controller => 'main', :action => 'welcome')
      return false
    else
      return true
    end
    else
      redirect_to(:controller => 'main', :action => 'login')
      return false
    end
  end
  
  # ohranicenie neprihlaseneho
  def not_logged
    if session[:user_id]
      redirect_to(:controller => 'main', :action => 'index')
      return false
    else
      return true
    end
  end
  
end
