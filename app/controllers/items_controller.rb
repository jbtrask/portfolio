class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    if !params["classification_id"].nil?
      @items = Item.all.select{|i| i.classification.id == params[:classification_id]}
    else
      @items = Item.all.shuffle
    end
    @filters = []

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end

  def style

    number_of_regions = 10000
    max_resolution = 1600

    @screens = []
    @elements = []
    (1..number_of_regions).each do |i|
      increment = max_resolution.to_f / number_of_regions.to_f
      @screens << [(increment * i).to_i, (increment * i).to_i]
      @elements << [((increment * i) / 6.0).floor, ((increment * i) / 4.0).floor]
    end

    respond_to do |format|
      format.html
      format.css { render 'style.css.erb', :content_type => "text/css" }
    end

  end

end
