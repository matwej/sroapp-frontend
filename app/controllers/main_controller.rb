# -*- encoding : utf-8 -*-
require 'digest/sha1'

class MainController < ApplicationController
  
  # filter ohranicenia pristupu pre prihlaseneho/neprihlaseneho
  before_filter :logged_in, :only => [:index, :show_prof, :edit_prof, :cr_prof, :del_prof, :logout]
  before_filter :not_logged, :only => [:welcome, :login, :register]
  
  def index
    # uvodna domovska stranka render
  end
  
  def welcome
    # uvodna stranka
  end
  
  def show_prof
    # zobrazenie profil
    @profile = Profile.find_by user_id: session[:user_id]
  end

  def edit_prof
    # stranka editacie profilu
    @profile = Profile.find_by user_id: session[:user_id]
  end

  def cr_prof
    # vytvaranie profilu
    @profile = Profile.new 
  end
  
  # vytvorenie profilu, post metoda
  def create_profile
    @profile = Profile.new(profile_params)
    @profile.user_id = session[:user_id]
    if @profile.save
      flash[:notice] = "Profil vytvorený."
      flash[:cr_prof]= "valid"
    else
      flash[:notice] = "Nevytvorený. Formulár nie je validný, prosím opravte chyby."
      flash[:cr_prof]= "invalid"
    end
    render "cr_prof"
  end

  # vymazanie profilu, post metoda
  def delete_prof
    profile = Profile.find_by user_id: session[:user_id]
    if profile.destroy
      flash[:notice] = "Profil vymazaný."
      flash[:edited]= "valid"
    end
    redirect_to(:action => 'show_prof')
  end
  
  #zmena profilu, patch metoda
  def action_edit_prof
    profile = Profile.find_by user_id: session[:user_id]
    if profile.update_attributes(profile_params)
      flash[:notice] = "Profil zmenený."
      flash[:edited]= "valid"
    else
      flash[:notice] = "Chyba formulára. Profil nezmenený."
      flash[:edited]= "invalid"
    end
    redirect_to(:action => 'show_prof')
  end

  # vyrenderovanie noveho pouzivatela, aj formular
  def register
    @user = User.new
  end
  
  # vytvorenie uzivatela, formularova post metoda
  def cr_acc
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Úspešne ste sa zaregistrovali."
      flash[:register]= "valid"
    else
      flash[:notice] = "Formulár nie je validný. Prosím opravte chyby na základe kontroly."
      flash[:register]= "invalid"
    end
    render "register"
  end
  
  # editovanie emailu pouzivatela, post metoda
  def edit_user_email
    user = User.find(session[:user_id])
    if user.update(email: params[:user][:email])
      flash[:notice] = "E-mail zmenený na " + params[:user][:email]
      flash[:edited]= "valid"
    else
      flash[:notice] = "Email nie je validný."
      flash[:edited]= "invalid"
    end
    redirect_to(:action => 'show_prof')
  end

  # editovanie hesla pouzivatela, post metoda
  def edit_user_pass
    user = User.find(session[:user_id])
    auth_user = User.auth(user.login,params[:user][:old_pass])
    if user.update(pass: params[:user][:pass]) && auth_user
      flash[:notice] = "Heslo zmenené."
      flash[:edited]= "valid"
    else
      flash[:notice] = "Nesprávne zadané heslo."
      flash[:edited]= "invalid"
    end
    redirect_to(:action => 'show_prof')
  end

  # renderovanie prihlasenia
  def login
    # formular prihlasenia
  end
  
  # prihlasenie, post metoda formulara
  def action_login
    auth_user = User.auth(params[:user_or_email],params[:prov_pass])
    if auth_user
      session[:user_id] = auth_user.id
      flash[:notice] = "Boli ste úspešne prihlásený ako #{auth_user.login}."
      flash[:logged]= "valid"
      redirect_to(:action => 'index')
    else
      flash[:notice] = "Nesprávne meno alebo heslo."
      flash[:logged]= "invalid"
      render "login"
    end
  end
  
  # odhlasenie
  def logout
    session[:user_id] = nil
    redirect_to(:action => 'welcome')
  end
  
  # zapuzdrenie parametrov, nepripustnost ziadnych inych, bezpecnostna polozka znama v Rails4
  private
  def user_params    
    params.require(:user).permit(:login, :pass, :pass_confirmation, :email)
  end
  def profile_params
    params.require(:profile).permit(:t_pred, :t_za, :meno, :priez, :ulica, :cislo, :obec, :psc, :stat)
  end
end
