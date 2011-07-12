class GoogleMapsController < ApplicationController
  
  before_filter :user_ip

  def home
    @user_ip = user_ip
    # TODO implement geocode methods GoogleMap::MultiGeocoder.geocode(ip || city)
    @geocode_info = GoogleMap::MultiGeocoder.geocode(user_ip)
  end

  def show_weather
    lat = params[:lat].blank? ? '498377195' : params[:lat].gsub(".","")[0..7]
    lng = params[:lng].blank? ? '24008442' : params[:lng].gsub(".","")[0..7]
    city = 'Lviv'
    res = Net::HTTP.get("www.google.com", "/ig/api?weather=#{city},,,#{lat},#{lng}")
    hash = Hash.from_xml(res)
    hash = HashWithIndifferentAccess.new(hash)
    weather = hash[:xml_api_reply][:weather]
    info = weather[:forecast_information]
    conditions= weather[:current_conditions]
    forecast = weather[:forecast_conditions]
    # TODO format and render xml data on weather block
    hash = {:city => info[:city][:data],
            :temp => conditions[:temp_c][:data],
            :hum => conditions[:humidity][:data],
            :wind => conditions[:wind_condition][:data]}
    render :json => hash
  end

  # GET /google_maps
  # GET /google_maps.xml
  def index

    @google_maps = GoogleMap.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @google_maps }
    end
  end

  # GET /google_maps/1
  # GET /google_maps/1.xml
  def show
    @google_map = GoogleMap.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @google_map }
    end
  end

  # GET /google_maps/new
  # GET /google_maps/new.xml
  def new
    @google_map = GoogleMap.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @google_map }
    end
  end

  # GET /google_maps/1/edit
  def edit
    @google_map = GoogleMap.find(params[:id])
  end

  # POST /google_maps
  # POST /google_maps.xml
  def create
    @google_map = GoogleMap.new(params[:google_map])

    respond_to do |format|
      if @google_map.save
        format.html { redirect_to(@google_map, :notice => 'Google map was successfully created.') }
        format.xml  { render :xml => @google_map, :status => :created, :location => @google_map }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @google_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /google_maps/1
  # PUT /google_maps/1.xml
  def update
    @google_map = GoogleMap.find(params[:id])

    respond_to do |format|
      if @google_map.update_attributes(params[:google_map])
        format.html { redirect_to(@google_map, :notice => 'Google map was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @google_map.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /google_maps/1
  # DELETE /google_maps/1.xml
  def destroy
    @google_map = GoogleMap.find(params[:id])
    @google_map.destroy

    respond_to do |format|
      format.html { redirect_to(google_maps_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
  
  def user_ip
    @client_ip = request.remote_ip  
  end

end
