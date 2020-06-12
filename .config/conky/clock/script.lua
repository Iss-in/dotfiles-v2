-- This is a lua script for use in Conky.
require 'cairo'

function conky_main ()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create (conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create (cs)
    local updates = tonumber (conky_parse ('${updates}'))
    -- if updates > 5 then
    --     print ("hello world")
    -- end
        -- SETTINGS
    -- rings size
    ring_center_x = 130
    ring_center_y = 115
    ring_radius = 98
    ring_width = 2
    -- Colors.

    -- Set background colors, 1, 0, 0, 1 = fully opaque red.  progressbar
    ring_bg_red = 0.44919100000000001
    ring_bg_green = 0.39611199999999996
    ring_bg_blue = 0.40318500000000002
    ring_bg_alpha = 1


    -- Set indicator colors, 1, 1, 1, 1 = fully opaque white.
    ring_in_red = 1
    ring_in_green = 1
    ring_in_blue = 1
    ring_in_alpha = 1








    line_width = 4
    line_cap = CAIRO_LINE_CAP_BUTT
    red_background, green_background, blue_background, alpha = 0, 0, 0, 1
    startx = 30
    starty = 90
    endx = 230
    endy = 120


    -- progressbar
 
    pat2 = cairo_pattern_create_linear (0, 0, 250 , 290.0)
    cairo_pattern_add_color_stop_rgba (pat2, 0, 1, 0.72, 0.42, 1)
    cairo_pattern_add_color_stop_rgba (pat2, 0.5, 0.45945399999999997, 0.265737, 0.14605499999999999, 1)
    cairo_set_source (cr, pat2)
    cairo_move_to (cr, startx, starty)
    cairo_line_to (cr, endx, endy)
    --cairo_stroke (cr)
    cairo_pattern_destroy (pat2)


  
    local handle = io.popen("date +'%d'")
    local date = handle:read("*a")
    handle:close()
    -- print(date)
    pat2 = cairo_pattern_create_linear (0, 15, 0 , 170.0)
    -- pat2 = cairo_pattern_create_radial (0, 0, 0 , 0,0, 340)
    cairo_pattern_add_color_stop_rgba (pat2, 0, 0, 0.9, 1, 1)
    cairo_pattern_add_color_stop_rgba (pat2, 0.5, 0.4, 1, 0.6, 1)
    cairo_set_source (cr, pat2)

  cairo_select_font_face(cr, "Bebas Neue Light",
      CAIRO_FONT_SLANT_NORMAL,
      CAIRO_FONT_WEIGHT_LIGHT);

  cairo_set_font_size(cr, 120);

  cairo_move_to(cr, 25, 115);
  cairo_show_text(cr,  string.sub(date, 1, 2));  







    cairo_destroy (cr)
    cairo_surface_destroy (cs)
    cr = nil
end