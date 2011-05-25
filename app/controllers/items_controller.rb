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

  def style
        @lengths = {
      'mobile' => [480, [1, 1]],
      'extra_small' => [600, [2,3]],
      'small' => [720, [4, 6]],
      'medium' => [840, [6, 9]],
      'standard' => [960, [8, 12]],
      'large' => [1080, [10, 15]],
      'extra_large' => [1200, [12, 18]],
      'jumbo' => [1201, [14, 21]]
    } 
    
    @aspect_ratios = {
      'narrow_portrait' => "9/16",
      'square_portrait' => "3/4",
      'square_landscape' => "4/3",
      'wide_landscape' => "16/9"
    }  
    respond_to do |format|
      format.html
      format.css { render 'style.css.erb', :content_type => "text/css" }
    end
  end
  
  def sizes
    
    @lengths = {
      'mobile' => [480, [1, 1]],
      'extra_small' => [600, [2,3]],
      'small' => [720, [4, 6]],
      'medium' => [840, [6, 9]],
      'standard' => [960, [8, 12]],
      'large' => [1080, [10, 15]],
      'extra_large' => [1200, [12, 18]],
      'jumbo' => [1201, [14, 21]]
    } 
    
    @aspect_ratios = {
      'narrow_portrait' => "9/16",
      'square_portrait' => "3/4",
      'square_landscape' => "4/3",
      'wide_landscape' => "16/9"
    }  

    @values = @lengths.to_a.sort{|a, b| b[1][0] <=> a[1][0]}
    puts @values
    respond_to do |format|
      format.css { render "sizes.css.erb", :content_type => "text/css" }
    end
  end
  
  def test
    
  end

end
