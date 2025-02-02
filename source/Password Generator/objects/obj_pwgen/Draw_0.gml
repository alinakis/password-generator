//get current mouse position
var m = [device_mouse_x(0), device_mouse_y(0)];

//reset cursor state
window_set_cursor(cr_default);

//clear the background, reset draw color
draw_clear(c_background);
draw_set_color(c_white);

//buttons row 1
draw_button_pg(15, 99, 500, "Generate New Password", c_emerald, true, true, true, spr_icon_reload);
draw_button_pg(525, 99, 260, copy_label, c_mango, true, true, true, spr_icon_clipboard);

//buttons row 2
draw_button_pg(15, 173, 133, "Length", c_seafoam, false, true, false);
draw_button_pg(150, 173, 64, "-", c_seafoam, true, false, false);
draw_button_pg(216, 173, 64, "+", c_seafoam, true, false, false);

//draw the length area as an inactive button, and set the cursor to left/right arrows if the cursor is hovering over it
if (draw_button_pg(282, 173, 108, string(length), c_black, true, false, true))
{
	window_set_cursor(cr_size_we);
}

//buttons row 2
draw_button_pg(400, 173, 275, "Special Characters", c_seafoam, true, true, false);
var sc = "";
switch (special_chars)
{
	case 0:
	sc = "None";
	break;
	
	case 2:
	sc = "Full";
	break;
	
	default:
	sc = "Basic";
}

//draw the special character option as an inactive button
draw_button_pg(677, 173, 108, sc, c_black, false, false, true);

//draw the character breakdown panel, split into two or three areas (buttons row 3)
if (special_chars == 0)
{
	
	//width of each area
	var letters_area = (letters_percentage_nospecials / 100) * 770;
	var numbers_area = (numbers_percentage_nospecials / 100) * 770;
	
	//character counts for each section
	var numbers_count = max(floor(length * (numbers_percentage_nospecials / 100)), 1);
	var letters_count = length - numbers_count;
	
	//letter scaling
	var letter_scale = 0.65 * 0.5;
	
	//draw the caps and each area, subtracting 10 from each area that hits the endcaps
	draw_sprite_ext(spr_button, 0, 15, 247, 0.5, 0.5, 0, c_graph1, 1);
	draw_sprite_ext(spr_button, 1, 15 + 10, 247, (0.1 * (letters_area - 10)) * 0.5, 0.5, 0, c_graph1, 1);
	draw_sprite_ext(spr_button, 1, 15 + letters_area, 247, (0.1 * (numbers_area - 10)) * 0.5, 0.5, 0, c_graph2, 1);
	draw_sprite_ext(spr_button, 2, 775, 247, 0.5, 0.5, 0, c_graph2, 1);
	
	//area labels
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(15 + (letters_area * .5), 279, "Letters\n " + string(letters_percentage_nospecials) + "% (" + string(letters_count) + ")", letter_scale, letter_scale, 0);
	draw_text_transformed(15 + letters_area + (numbers_area * .5), 279, "Numbers\n " + string(numbers_percentage_nospecials) + "% (" + string(numbers_count) + ")", letter_scale, letter_scale, 0);
	
	//if the mouse is hovering over it, draw the boundary between the two sections and change the cursor to left/right arrows
	if ((m[0] > 15 + letters_area - 10) && (m[0] < 15 + letters_area + 10) && (m[1] > 247) && (m[1] < 311)) || (drag_mode_boundary3)
	{
		draw_sprite_ext(spr_button, 1, 15 + letters_area - 2.5, 247, 0.25, 0.5, 0, c_black, 1);
		window_set_cursor(cr_size_we);
	}
	
} else {
	
	//width of each area
	var letters_area = (letters_percentage / 100) * 770;
	var numbers_area = (numbers_percentage / 100) * 770;
	var specials_area = (specials_percentage / 100) * 770;
	
	//character counts for each section
	var numbers_count = max(floor(length * (numbers_percentage / 100)), 1);
	var specials_count = max(floor(length * (specials_percentage / 100)), 1);
	var letters_count = length - numbers_count - specials_count;
	
	//letter scaling
	var letter_scale = 0.65 * 0.5;

	//draw the caps and each area, subtracting 10 from each area that hits the endcaps
	draw_sprite_ext(spr_button, 0, 15, 247, 0.5, 0.5, 0, c_graph1, 1);
	draw_sprite_ext(spr_button, 1, 15 + 10, 247, (0.1 * (letters_area - 10)) * 0.5, 0.5, 0, c_graph1, 1);
	draw_sprite_ext(spr_button, 1, 15 + letters_area, 247, (0.1 * numbers_area) * 0.5, 0.5, 0, c_graph2, 1);
	draw_sprite_ext(spr_button, 1, 15 + letters_area + numbers_area, 247, (0.1 * (specials_area - 10)) * 0.5, 0.5, 0, c_graph3, 1);
	draw_sprite_ext(spr_button, 2, 775, 247, 0.5, 0.5, 0, c_graph3, 1);

	//area labels
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(15 + (letters_area * .5), 279, "Letters\n " + string(letters_percentage) + "% (" + string(letters_count) + ")", letter_scale, letter_scale, 0);
	draw_text_transformed(15 + letters_area + (numbers_area * .5), 279, "Numbers\n " + string(numbers_percentage) + "% (" + string(numbers_count) + ")", letter_scale, letter_scale, 0);
	draw_text_transformed(15 + letters_area + numbers_area + (specials_area * .5), 279, "Specials\n " + string(specials_percentage) + "% (" + string(specials_count) + ")", letter_scale, letter_scale, 0);

	//if the mouse is hovering over it, draw the boundary between the letters/numbers areas and change the cursor to left/right arrows
	if ((m[0] > 15 + letters_area - 10) && (m[0] < 15 + letters_area + 10) && (m[1] > 247) && (m[1] < 311) && !drag_mode_boundary2) || (drag_mode_boundary1 && !drag_mode_boundary2)
	{
		draw_sprite_ext(spr_button, 1, 15 + letters_area - 2.5, 247, 0.25, 0.5, 0, c_black, 1);
		window_set_cursor(cr_size_we);
	}
	
	//if the mouse is hovering over it, draw the boundary between the numbers/special characters areas and change the cursor to left/right arrows
	if ((m[0] > 15 + letters_area + numbers_area - 10) && (m[0] < 15 + letters_area + numbers_area + 10) && (m[1] > 247) && (m[1] < 311) && !drag_mode_boundary1) || (drag_mode_boundary2 && !drag_mode_boundary1)
	{
		draw_sprite_ext(spr_button, 1, 15 + letters_area + numbers_area - 2.5, 247, 0.25, 0.5, 0, c_black, 1);
		window_set_cursor(cr_size_we);
	}
}

//buttons row 4
draw_button_pg(15, 321, 64, "", c_blueberry, true, true, true, (hidden_mode ? spr_icon_eye_closed : spr_icon_eye_open));
draw_button_pg(89, 321, 64, "", c_blueberry, true, true, true, (scale_double ? spr_icon_compress : spr_icon_expand));
draw_button_pg(499, 321, 64, "", c_blueberry, true, true, true, spr_icon_load);
draw_button_pg(573, 321, 64, "", c_blueberry, true, true, true, spr_icon_save);
draw_button_pg(647, 321, 64, "", c_blueberry, true, true, true, spr_icon_reload);
//draw_button_pg(721, 321, 64, "", c_blueberry, true, true, true, spr_icon_info);

//draw password box
draw_button_pg(15, 15, 770, "", c_black, false, true, true);

//set text alignment
draw_set_halign(fa_center);

//password scale var, so we can change it later if the password gets too big for the box
var password_scale = 0.5;

//if hidden mode is on, just draw asterisks
if (hidden_mode)
{
	//use a special font for this so it looks how we want it to
	draw_set_font(fnt_asterisk);
	
	//set password draw scale
	var hidden_password = string_repeat("*", length);
	if ((string_width(hidden_password) * 0.5) > 750)
	{
		password_scale = 750 / string_width(hidden_password);
	}
	
	//draw the password as asterisks
	draw_text_transformed(400, 50, hidden_password, password_scale, password_scale, 0);
	
} else {
	
	//set to the default font for passwords
	draw_set_font(fnt_password);
	
	//set password draw scale
	if ((string_width(password) * 0.5) > 750)
	{
		password_scale = 750 / string_width(password);
	}
	
	//draw the password
	draw_text_transformed(400, 50, password, password_scale, password_scale, 0);
}