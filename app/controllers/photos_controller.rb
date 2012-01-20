class PhotosController < ApplicationController
  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    @albums = Album.find(:all)
    redirect_to :controller => 'albums', :action => 'show', :id => params[:album_id] if params[:album_id]
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @album = Album.find(params[:album_id]) if params[:album_id]
    @photo = @album ? @album.photos.find(params[:id]) : Photo.find(params[:id], :include => :albums)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.json
  def new
    @photo = Photo.new
    @albums = Album.find(:all)
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    @albums = Album.find(:all)
  end

  # POST /photos
  # POST /photos.json
  def create
      @albums = Album.find(:all)

    @photo = Photo.new(params[:photo])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render json: @photo, status: :created, location: @photo }
      else
        format.html { render action: "new" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.json
  def update
    @photo = Photo.find(params[:id])
    @albums = Album.find(:all)

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :ok }
    end
  end
  
	# GET /photos/orphaned 
	def orphaned 
		@photos = Photo.orphaned 
	end end
