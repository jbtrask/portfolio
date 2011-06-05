GRID_ASPECT_RATIO = 1.61803399
GRID_MIN = 20 #pixels
GRID_MAX = 200 #pixels
GRID_INCREMENT = 10 #pixels
GRID_PADDING = 2.0 #percent
MIN_GRID_SPACE = 1 #pixel

MATRIX_MIN_WIDTH = 1 #cell
MATRIX_MAX_WIDTH = 24 #cells
MATRIX_MIN_HEIGHT = 1 #cell
MATRIX_MAX_HEIGHT = 24 #cells
MATRIX_PADDING = 2.0 #percent
MIN_MATRIX_SPACE = 10 #px

MOBILE_LIMIT = 480 #pixels

CELL_COUNT = 24 #cells

CONTENT_PERCENT = {
  'standard' => 72.0, #percent
  'compressed' => 92.0, #percent
  'long' => 88.0 #percent
}

ASPECT_RATIOS = { # width / height
  'super_narrow_portrait' => ".25",
  'narrow_portrait' => ".4",
  'standard_portrait' => ".825",
  'compressed_portrait' => "1.0",
  'compressed_landscape' => "1.2",
  'standard_landscape' => "2.5",
  'wide_landscape' => "4.0",
  'super_wide_landscape' => nil
}

MINIMUM_LAYOUT = {
  'super_narrow_portrait' => [1, 1, 100.0, CONTENT_PERCENT['long']],
  'narrow_portrait' => [1, 2, 100.0, CONTENT_PERCENT['long']],
  'standard_portrait' => [4, 6, 100.0, CONTENT_PERCENT['standard']],
  'compressed_portrait' => [4, 6, 100.0, CONTENT_PERCENT['compressed']],
  'compressed_landscape' => [4, 6, CONTENT_PERCENT['compressed'], 100.0],
  'standard_landscape' => [4, 6, CONTENT_PERCENT['standard'], 100.0],
  'wide_landscape' => [2, 1, CONTENT_PERCENT['long'], 100.0],
  'super_wide_landscape' => [1, 1, CONTENT_PERCENT['long'], 100.0]
}

def space(length, percent, min = 0)
  space = (length.to_f * percent.to_f / 100.0).floor
  space = space < min.to_i ? min.to_i : space
  space
end

def corrected_length(content_length, content_percent)
  (content_length.to_f / (content_percent.to_f / 100.0)).ceil
end

def layout_to_html(layout)
  html = "name:  " + layout[:name]
  html += " | cell width:  " + layout[:size][:width].to_s
  html += " | cell height:  " + layout[:size][:height].to_s
  html += " | rows:  " + layout[:rows].to_s
  html += " | columns:  " + layout[:columns].to_s
  html += " | grid width space:  " + layout[:grid_width_space].to_s
  html += " | grid height space:  " + layout[:grid_height_space].to_s
  html += " | matrix width:  " + layout[:matrix_width].to_s
  html += " | matrix height:  " + layout[:matrix_height].to_s
  html += " | matrix width space:  " + layout[:matrix_width_space].to_s
  html += " | matrix height space:  " + layout[:matrix_height_space].to_s
  html += " | required width:  " + layout[:required_width].to_s
  html += " | required height:  " + layout[:required_height].to_s
  html += " | corrected required width:  " + layout[:corrected_required_width].to_s
  html += " | corrected required height:  " + layout[:corrected_required_height].to_s
  html
end

def layout_info(name, size, rows, columns, horizontal_content, vertical_content)
  info = {}
  info[:name] = name
  info[:size] = size
  info[:rows] = rows
  info[:columns] = columns
  info[:grid_width_space] = space(size[:width], GRID_PADDING, MIN_GRID_SPACE)
  info[:grid_height_space] = space(size[:height], GRID_PADDING, MIN_GRID_SPACE)
  info[:matrix_width] = columns * (size[:width] + info[:grid_width_space])
  info[:matrix_height] = rows * (size[:height] + info[:grid_height_space])
  info[:matrix_width_space] = space(info[:matrix_width], MATRIX_PADDING, MIN_MATRIX_SPACE)
  info[:matrix_height_space] = space(info[:matrix_height], MATRIX_PADDING, MIN_MATRIX_SPACE)
  info[:required_width] = info[:matrix_width] + 2 * info[:matrix_width_space]
  info[:required_height] = info[:matrix_height] + 2 * info[:matrix_height_space]
  info[:corrected_required_width] = corrected_length(info[:required_width], horizontal_content)
  info[:corrected_required_height] = corrected_length(info[:required_height], vertical_content)
  info
end

def ratio_list
  list = []
  (MATRIX_MIN_WIDTH..MATRIX_MAX_WIDTH).each do |width|
    (MATRIX_MIN_HEIGHT..MATRIX_MAX_HEIGHT).each do |height|
      list << { :width => width, :height => height, :ratio => width.to_f / height.to_f }
    end
  end
  list.sort{|entry1, entry2| entry1[:ratio] <=> entry2[:ratio] }
end

def ratio_from_value(value)
  list = ratio_list
  ratio = list.first[:width].to_s + "/" + list.first[:height].to_s
  ratio_list.each do |entry|
    ratio = entry[:width].to_s + "/" + entry[:height].to_s if value.to_f >= entry[:ratio]
  end
  ratio
end

def value_from_ratio(ratio)
  values = ratio.split("/")
  values[0].to_f / values[1].to_f
end

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
