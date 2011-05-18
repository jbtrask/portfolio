// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


/*$(window).resize(setSize());

function setSize() {
	$('#dimensions').html("<span>" + $(window).width() + ", " + $(window).height() +"</span>");
}

*/

var $$ = jQuery.noConflict();
     
$$(document).ready(function() {
	
	$$("#work").click(function(){
		$$("#filter").fadeToggle();	
	});
	
	$$("#work").mouseout(function(){
		$$("#work").removeClass("navHover");
	});
	$$("#work").mouseenter(function(){
		$$("#work").addClass("navHover");	
	});
	
	setSize();
});
 
$$(window).resize(setSize);

function setSize() {
	
	var rows = 4;
	var cols = 6;
	var padding = 2;
	var margin = 10;
	var sidebar = 250;
	var h_square, v_square, square;
	
	// Portrait
	if ($$(window).height() > $$(window).width())
	{
		h_square = $$(window).width() - 2 * margin;
		v_square = $$(window).height() - sidebar - 3 * margin;
		square = h_square < v_square ? h_square : v_square;
		square = square < sidebar ? sidebar : square;
		
		$$("#masthead").css("top", ($$(window).height() - sidebar - square - margin) / 2 + "px");	
		$$("#masthead").css("left", ($$(window).width() - square) / 2 + "px");	
		$$("#masthead").css("width", square + "px");
		$$("#masthead").css("height", sidebar + "px");
		
		$$("#div_b").css("top", ($$(window).height() - sidebar - square - margin) / 2 + sidebar + margin + "px");	
		$$("#div_b").css("left", ($$(window).width() - square) / 2 + "px");	
		$$("#div_b").css("width", square + "px");	
		$$("#div_b").css("height", square + "px");
		
		$$("#nav").css("top", sidebar / 2 - $$("#nav").height() / 2 + "px");
		$$("#copyright").css("bottom", ($$(window).height() - sidebar - square - margin) / 2  - $$("#copyright").height() + "px");
		$$("#copyright").css("left", ($$(window).width() - square) / 2 + square - $$("#copyright").width() + "px");	
	}
	// Landscape
	else
	{
		h_square = $$(window).width() - sidebar - 3 * margin;
		v_square = $$(window).height() - 2 * margin;
		square = h_square < v_square ? h_square : v_square;
		square = square < sidebar ? sidebar : square;
		
		$$("#masthead").css("top", ($$(window).height() - square) / 2 + "px");	
		$$("#masthead").css("left", ($$(window).width() - sidebar - square - margin) / 2 + "px");	
		$$("#masthead").css("width", sidebar + "px");
		$$("#masthead").css("height", square + "px");
		
		$$("#div_b").css("top", ($$(window).height() - square) / 2 + "px");	
		$$("#div_b").css("left", ($$(window).width() - sidebar - square - margin) / 2 + sidebar + margin + "px");	
		$$("#div_b").css("width", square + "px");	
		$$("#div_b").css("height", square + "px");
		
		$$("#nav").css("top", square / 4 + "px");
		$$("#copyright").css("bottom", ($$(window).height() - square) / 2 - $$("#copyright").height() + "px");	
		$$("#copyright").css("left", ($$(window).width() - sidebar - square - margin) / 2 + sidebar + margin + square - $$("#copyright").width() + "px");	
	}
	
	var thumb_width = Math.floor((square - (cols - 1) * padding) / cols);
	var thumb_width_remain = (square - (cols - 1) * padding) % cols;
	var thumb_height = Math.floor((square - (rows - 1) * padding) / rows);
	var thumb_height_remain = (square - (rows - 1) * padding) % rows;
	
	
	for(var row = 0; row < rows; row++)
	{
		$$("li.row_" + (row + 1)).css("height", thumb_height + (row < thumb_height_remain ? 1 : 0));
		$$("li.row_" + (row + 1)).css("min-height", thumb_height + (row < thumb_height_remain ? 1 : 0));
	}	
	
	for(var col = 0; col < cols; col++)
		$$("li.col_" + (col + 1)).css("width", thumb_width + (col < thumb_width_remain ? 1 : 0));
	
	$$(".row_" + rows).css("margin-bottom", "0px");
	$$(".col_" + cols).css("margin-right", "0px");	
}
 
