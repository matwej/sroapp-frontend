# -*- encoding : utf-8 -*-
require 'uri'
class SroController < ApplicationController
  
  # ohranicenie pristupu
  before_filter :logged_in, :only => [:show, :create, :step2, :step3, :step4, :step5, :step6, :step7, :step8]
  
  # udaje pre volania back-endu
  USERNAME = "frontend"
  PASSWORD = "frontend"
  API_BASE_URL = "http://localhost:4567"
  
  # typy osob: 1 - spolocnik, 2 - konatel, 3 - clen dozornej rady
  # vsetky kroky su overovane na prave zadany step v objekte spolocnosti, aby sa nedali preskakovat
  
  def show
    # zoznam spolocnosti
    @sros = User.find(session[:user_id]).sros
  end
  
  # vytvorenie spolocnosti, render formular
  def create
    @sro = Sro.new
    @navrh = Profile.find_by user_id: session[:user_id]
    if !@navrh
      flash[:notice] = "Profil nevyplnený. Navrhovateľom je práve príhlásený používateľ."
      flash[:step1]= "invalid"
      redirect_to(:action => 'show')
    end
  end
  
  # action metoda ulozenia spolocnosti
  def step12
    @sro = Sro.new(sro_params)
    @sro.user_id = session[:user_id]
    @sro.forma = "sro"
    if !@sro.save
      flash[:notice] = "Chyba zadaných údajov"
      flash[:step1]= "invalid"
      @navrh = Profile.find_by user_id: session[:user_id]
      render "create"
    else
      redirect_to(:action => 'step2', :sro_id => @sro.id)
    end
  end
  
  # render cinnosti
  def step2
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
    @all_operations = Operation.all
    @group = @sro.opandsros.build
  end
  
  # overenie cinnosti v backende, vytvorenie cinnosti ku spolocnosti
  def step23
    @sro = Sro.find(params[:sro][:id])
    @group = @sro.opandsros.build
    @all_operations = Operation.all
    @resps = []
    @next = true
    params[:sro][:operation_ids].delete_if(&:blank?)
    params[:sro][:operation_ids].each {|oid|
      o = Operation.find(oid)
      uri = "#{API_BASE_URL}/checkop/"+URI::encode(@sro.nazov+"/"+o.popis)
      rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
      begin
        resp = rest_resource.get
      rescue
        flash[:notice] = "Vzdialená databáza ŽRSR nedostupná, skúste neskôr."
        flash[:status]= "invalid"
        render 'step2' and return
      end
      if resp.eql? "0"
        @next = false
        @resps << o.popis
      end
    }
    if @next
      @sro.update_attributes(:proces => "step3")
      redirect_to(:action => 'step3', :sro_id => @sro.id)
    else
      redirect_to(:action => 'step2', :sro_id => @sro.id, :resps => @resps)
    end
  end
  
  # pridavanie spolocnikov
  def step3
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
    @person = Person.new
    @all_asso = Person.where(:typ => 1, :sro_id => @sro.id)
  end 
  
  # action metoda na overenie spolocnikov a ulozenie
  def step34
    @next = true
    # kontrola poctu spolocnikov
    @asso = Person.where(:typ => 1, :sro_id => params[:sro][:id])
    @asso.each {|a|
        uri = "#{API_BASE_URL}/checktax/"+a.rc.sub!('/','-')
        rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
      begin
        resp = rest_resource.get
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
        flash[:notice] = "Vzdialená databáza DÚSR pre overenie podlžnosti na dani nedostupná, skúste neskôr."
        flash[:status]= "invalid"
        redirect_to(:action => 'step3', :sro_id => params[:sro][:id]) and return
      end
      if resp.eql? "true"
        @next = false
      end
    }
    if @next
      if @asso.size == 1
        if Person.where(:typ => 1, :id => @asso.first).size > 2
          flash[:notice] = "Spoločník už je jediným spoločníkom v dvoch spoločnostiach s ručením obmedzeným."
          flash[:status]= "invalid"
          redirect_to(:action => 'step3', :sro_id => params[:sro][:id])
        else
          Sro.find(params[:sro][:id]).update_attributes(:proces => "step4")
          redirect_to(:action => 'step4', :sro_id => params[:sro][:id])
        end
      elsif @asso.size > 1
        Sro.find(params[:sro][:id]).update_attributes(:proces => "step4")
        redirect_to(:action => 'step4', :sro_id => params[:sro][:id])
      else
        flash[:notice] = "Minimálne jeden spoločník potrebný."
        flash[:status]= "invalid"
        redirect_to(:action => 'step3', :sro_id => params[:sro][:id])
      end
    else
      flash[:notice] = "Jeden alebo viac spoločníkov má daňové podlžnosti, prosím kontaktuje Daňový Úrad SR a pokračujte vo vytváraní po vyrovaní podlžností."
      flash[:status]= "invalid"
      redirect_to(:action => 'step3', :sro_id => params[:sro][:id])
    end
  end
    
  # pridavanie konatelov, formular
  def step4
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
    @person = Person.new
    @all_mdir = Person.where(:typ => 2, :sro_id => @sro.id)  
  end
  
  # action metoda pre pridanie konatelov a overovanie
  def step45
    @mdir = Person.where(:typ => 2, :sro_id => params[:sro][:id])
    if @mdir.size < 1
      flash[:notice] = "Minimálne jeden konateľ potrebný."
      flash[:status]= "invalid"
      redirect_to(:action => 'step4', :sro_id => params[:sro][:id])
    else
      Sro.find(params[:sro][:id]).update_attributes(:proces => "step5")
      redirect_to(:action => 'step5', :sro_id => params[:sro][:id])
    end
  end
  
  # pridavanie dozornej rady
  def step5
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
    @person = Person.new
    @all_sup = Person.where(:typ => 3, :sro_id => @sro.id)      
  end
  
  # action metoda pre pridanie a overenie dozornej rady
  def step56
    @sups = Person.where(:typ => 3, :sro_id => params[:sro][:id])
    if @sups.size < 3
      flash[:notice] = "Minimálne traja členovia dozornej rady potrební."
      flash[:status]= "invalid"
      redirect_to(:action => 'step5', :sro_id => params[:sro][:id])
    else
      Sro.find(params[:sro][:id]).update_attributes(:proces => "step6")
      redirect_to(:action => 'step6', :sro_id => params[:sro][:id])
    end    
  end
  
  # imanie, formular
  def step6
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
  end
  
  # action metoda pre nastavenie imania a bankoveho spojenia, overenie backendom
  def step67
    @sro = Sro.find(params[:sro][:id])
    if params[:banka][:iban].empty? || params[:sro][:imanie].empty? || params[:sro][:splatene].empty?
      flash[:notice] = "Všetky polia musia byť vyplnené"
      flash[:status]= "invalid"
      render 'step6' and return
    end
    uri = "#{API_BASE_URL}/getStatus/"+params[:banka][:iban]
    rest_resource = RestClient::Resource.new(uri, USERNAME, PASSWORD)
    begin
      resp = rest_resource.get
    rescue
      flash[:notice] = "Vzdialená databáza banky momentálne nedostupná, skúste neskôr."
      flash[:status]= "invalid"
      render 'step6' and return
    end
    @sro.proces = "step7"
    # @sro.update_attributes(:proces => "step7")
    if @sro.update_attributes(sro_params)
      if resp.eql? params[:sro][:splatene]
        redirect_to(:action => 'step7', :sro_id => params[:sro][:id]) and return
      else
        flash[:notice] = "Stav účtu podľa aktuálnych bankových údajov nekorešponduje, prosím vyrovnajte stav účtu pred pokračovaním."
        flash[:status]= "invalid"
        render 'step6' and return
      end
    end
    render 'step6'
  end
  
  # pridanie dokumentov, formular
  def step7
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
    @zip = Zip.new
  end
  
  # action metoda na pridavanie dokumentov
  def step78
    @sro = Sro.find(params[:sro][:id])
    if !params[:zip]
      flash[:notice] = "Nevybrali ste žiadny súbor"
      flash[:status]= "invalid"
      render 'step7' and return
    end
    @zip = Zip.new(zip_params)
    @zip.sro_id = params[:sro][:id]
    ziptmp = Zip.find_by sro_id: @sro.id
    if ziptmp
      ziptmp.destroy
    end
    if @zip.save
      @sro.update_attributes(:proces => "step8")
      redirect_to(:action => 'step8', :sro_id => @sro.id)
    else
      flash[:notice] = "Nastala chyba pri ukladaní dokumentu"
      flash[:status]= "invalid"
      render "step7"
    end
  end
  
  # posledny krok v ktorom proces konci a ocakava schvalenie
  def step8
    begin
      @sro = Sro.find(params[:sro_id])
    rescue
      redirect_to(:action => 'show') and return
    end
    @zip = Zip.find_by sro_id: params[:sro_id]
  end
    
  # aciton metoda na mazanie rozpracovanej spolocnosti
  def delete
    @sro = Sro.find(params[:sro_id])
    if @sro.destroy
      flash[:notice] = "Proces založenia vymazaný."
      flash[:deleted]= "valid"
    end
    redirect_to(:action => 'show')
  end

  # zapuzdrenie parametrov, zname v Rails4
  private
 
  def sro_params
    params.require(:sro).permit(:id, :ulica, :cislo, :obec, :psc, :stat, :nazov, :proces, :ico, :forma, :imanie, :splatene, :document, :user_id, operation_ids: [])
  end
  
  def person_params
    params.require(:person).permit(:id, :ulica, :cislo, :obec, :psc, :stat, :t_pred, :meno, :priez, :t_za, :vklad, :typ, :splatene, :sposob, :rc, :dat_nar)
  end
  
  def zip_params
    begin  
      params.require(:zip).permit(:id, :sro_id, :file)
    rescue
    end
  end
  
end
