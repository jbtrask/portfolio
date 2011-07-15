
$$(document).ready(function() {

	window.addEventListener('touchstart', touchStart, false);
	window.addEventListener('touchend', touchEnd, false);
	
/*	$$(window).resize(setSize());
	setSize();
	
	$$(window).swipe(function() { alert('swipe'); });
	//$$(window).scrollstop(function() { alert('scroll'); });
	$$(window).orientationchange(function() { alert('orientation'); });	
*/
});

var touchStartEvent;

function touchStart(event) {
	touchStartEvent = event;
}

function touchEnd(event) {
	alert("start (" + touchStartEvent.touches[0].screenX + ", " + touchStartEvent.touches[0].screenY + ") - end (" + event.touches[0].screenX + ", " + event.touches[0].screenY + ")";
}

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
