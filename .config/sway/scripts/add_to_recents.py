#!/usr/bin/python3

import gi, sys
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gio, GLib

rec_mgr = Gtk.RecentManager.get_default()

for arg in sys.argv[1:]:
    rec_mgr.add_item(Gio.File.new_for_path(arg).get_uri())

GLib.idle_add(Gtk.main_quit)
Gtk.main()
