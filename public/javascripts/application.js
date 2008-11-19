// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery(document).ready(function () {
	// Fix righ_col height v.s left_col height
	var rc = jQuery("#right_col");
	var lc = jQuery("#left_col");

	if (parseInt(rc.css("height")) < parseInt(lc.css("height"))) {
		rc.css("height", lc.css("height"));
	}
	
	// Always keep free_shipping icon at the bottom
	jQuery("#free_shipping").css("padding-top",
		(parseInt(rc.css("height")) - 260) + "px"
	);
	
	if (parseInt(rc.css("height")) < parseInt(lc.css("height"))) {
		rc.css("height", lc.css("height"));
	}	
});