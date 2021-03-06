$(document).ready(function(){

	//store first set of exercise param inputs for cloning
	$ex = $("#ex_select_prototype").contents();

	//counter for number of exercises added
	$ex_num = 1;

	$("#addbutton").hover(function() {
		$(this).toggleClass("button_hover");
	});

	//create the first exercise select
	$("#first_ex").replaceWith($ex.clone());

	update_ex_select_listeners();

	$("#addbutton").click(function() {
		//make a new set of exercise param inputs based on first one
		$("form").children(".ex").last().after($ex.clone());

		//increment exercise number
		$ex_num = parseInt($ex_num) + 1;

		//update form input ids
		$name = "ex_" + $ex_num + "_items"
		$("form").children(".ex:last").children().each( function() {
			$(this).children(":first").attr('name', $(this).children(":first").attr('name').replace(/\d+/,$ex_num));
		});

	update_ex_select_listeners();

	});
});

function update_ex_select_listeners() {
	//add exercise-specific options when exercise type is selected
	$(".ex_type_select").off("change"); //avoid accumulating duplicate listeners
	$(".ex_type_select").on("change", function() { 

		//retrieve options for selected ex type
		$type = $(this).children(":selected").text();
		$options = $("#ex_type_options_prototypes").children("." + $type);

		//if their are no options found for this ex type, insert default instead
		if($options.length == 0) { 
			$options = $("#ex_select_prototype").children().children(".ex_type_options");
		} 
		$(this).parent().siblings(".ex_type_options").replaceWith($options.clone());

		//get exercise number by searching name attribute for first number
		$ex_num = /\d+/.exec($(this).attr("name"))[0];

		//modify name parameter for form elements in added options to reflect ex num
		$(this).parent().siblings(":last").children().each(function() {
			$(this).attr('name', $(this).attr('name').replace(/\d+/,$ex_num));
		});
	});
}
