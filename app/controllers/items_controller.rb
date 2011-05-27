SIZE_GRID_ASPECT_RATIO = 1.61803399
SIZE_GRID_MIN = 60
SIZE_GRID_MAX = 300
SIZE_GRID_INCREMENT = 5
SIZE_GRID_SPACING = 2

SIZE_HORIZONTAL_MIN = 100
SIZE_HORIZONTAL_MAX = 1900
SIZE_HORIZONTAL_INCREMENT = 100

SIZE_VERTICAL_MIN = 100
SIZE_VERTICAL_MAX = 1600
SIZE_VERTICAL_INCREMENT = 100

SIZE_MOBILE_LIMIT = 480

ITEM_COUNT = 100

LENGTHS = {
  'mobile' => [480, [1, 1]],
  'extra_small' => [600, [2,2]],
  'small' => [720, [3, 3]],
  'medium' => [840, [4, 4]],
  'standard' => [960, [5, 5]],
  'large' => [1080, [6, 6]],
  'extra_large' => [1200, [7, 7]],
  'jumbo' => [1201, [8, 8]]
}

MOBILE_THRESHOLD = 480

ASPECT_RATIOS = {
  'narrow_portrait' => "1/2",
  'square_portrait' => "3/4",
  'square_landscape' => "4/3",
  'wide_landscape' => "2/1"
}

VERTICAL_COUNT = [
  [180, 1],
  [360, 2],
  [540, 3],
  [720, 4],
  [900, 5],
  [1080, 6],
  [1260, 7],
  [1440, 8],
  [1620, 9],
  [1800, 10],
  [1980, 11],
  [nil, 12]
]

HORIZONTAL_COUNT = [
  [120, 1],
  [240, 2],
  [360, 3],
  [480, 4],
  [600, 5],
  [720, 6],
  [840, 7],
  [960, 8],
  [1080, 9],
  [1200, 10],
  [1320, 11],
  [nil, 12]
]

SIDEBAR_WIDTH = {
  'compressed' => 10,
  'long' => 25,
  'normal' => 30
}


SIZES = [
  [50, 81],
  [100, 162],
  [150, 243]
]

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

#  def style
#    @lengths = LENGTHS
#    @aspect_ratios = ASPECT_RATIOS
#    respond_to do |format|
#      format.html
#      format.css { render 'style.css.erb', :content_type => "text/css" }
#    end
#  end

  def sizes
    @values = LENGTHS.to_a.sort{|a, b| b[1][0] <=> a[1][0]}
    puts @values
    respond_to do |format|
      format.css { render "sizes.css.erb", :content_type => "text/css" }
    end
  end

  def demo
    @mobile_threshold = MOBILE_THRESHOLD
    @aspect_ratios = ASPECT_RATIOS
  end

  def style
    @h_count = HORIZONTAL_COUNT
    @v_count = VERTICAL_COUNT
    @sidebar_width = SIDEBAR_WIDTH
    respond_to do |format|
      format.css { render "items/style/#{params[:stylesheet]}.css.erb", :content_type => "text/css" }
    end
  end

  def test

  end

end
