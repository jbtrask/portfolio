GRID_ASPECT_RATIO = 1.61803399
GRID_MIN = 50 #pixels
GRID_MAX = 300 #pixels
GRID_INCREMENT = 12 #pixels
GRID_PADDING = 2.0 #percent
MIN_GRID_SPACE = 1 #pixel

MATRIX_MIN_WIDTH = 1 #cell
MATRIX_MAX_WIDTH = 12 #cells
MATRIX_MIN_HEIGHT = 1 #cell
MATRIX_MAX_HEIGHT = 12 #cells
MATRIX_PADDING = 5.0 #percent
MIN_MATRIX_SPACE = 15 #px

MOBILE_LIMIT = 480 #pixels

CELL_COUNT = 24 #cells

CONTENT_PERCENT = {
  'normal' => 68.0, # %
  'compressed' => 92.0, # %
  'long' => 85.0 # %
}

ASPECT_RATIOS = {
  'narrow_portrait' => "1/2",
  'square_portrait' => "3/4",
  'square_landscape' => "4/3",
  'wide_landscape' => "2/1"
}

class ItemsController < ApplicationController

  # GET /items
  # GET /items.xml
  def index
    @classification = params[:classification_id].nil? ? nil : Classification.find(params[:classification_id])
    @medium = params[:medium_id].nil? ? nil : Medium.find(params[:medium_id])
    @period = params[:period_id].nil? ? nil : Period.find(params[:period_id])
    @filters = []
    if !@classification.nil? && !@medium.nil? && !@period.nil?
      @items = Item.where("classification_id = ? AND medium_id = ? AND period_id = ?", @classification.id, @medium.id, @period.id)
    else
      @items = Item.all.shuffle
    end
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

  def demo
  end

  def style
    respond_to do |format|
      format.css { render "items/style/#{params[:stylesheet]}.css.erb", :content_type => "text/css" }
    end
  end

end
