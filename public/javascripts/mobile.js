
$$(document).ready(function() {

	$$(window).resize(setSize());
	setSize();
	
	$$(window).swipe(function() { alert('swipe'); });
	$$(window).scrollstop(function() { alert('scroll'); });
	$$(window).orientationchange(function() { alert('orientation'); });	
	
});

function setSize() {
	console.log('setSize');
/*
 	$$("li").each(function() {$
		this.css("width", $(window).width * 0.26);
		this.css("margin-right", )
		
		$(this).css("width", "30%");
		$(this).css("margin-right: 2%");
		$(this).css("margin-bottom: 2%");
	});
*/
}
