using Gtk;


public class SystrayMenuStart: Gtk.MenuItem {
  // TODO when refresh, we try to change the label to Stop
  public SystrayMenuStart() {
    this.set_label("Start");
    this.activate.connect(on_click_main_action);
  }

  private void on_click_main_action() {
    if (this.get_label() == "Start") {
      print("Start\n");
    }
    else {
      print("Stop\n");
    }
  }
}


public class SystrayMenuStatus: Gtk.MenuItem {
  public SystrayMenuStatus() {
    this.set_label("Status");
    this.activate.connect(on_click_check_status);
  }

  private void on_click_check_status() {
    print("Clicked check status");
  }
}


public class SystrayMenuCheckIP: Gtk.MenuItem {
  public SystrayMenuCheckIP() {
    this.set_label("Check IP");
    this.activate.connect(on_click_check_ip);
  }

  private void on_click_check_ip() {
    print("Clicked check ip\n");
  }
}


public class SystrayMenuSettings: Gtk.MenuItem {
  public SystrayMenuSettings() {
    this.set_label("Settings");
    this.activate.connect(on_click_settings);
  }

  private void on_click_settings() {
    var dialog_options = new AnonSurfDialogOptions();
    dialog_options.run();
    dialog_options.destroy();
  }
}


public class SystrayMenuQuit: Gtk.MenuItem {
  public SystrayMenuQuit() {
    this.set_label("Quit");
    this.activate.connect(Gtk.main_quit);
  }
}


public class AnonSurfSystrayMenu: Gtk.Menu {
  public AnonSurfSystrayMenu() {
    // FIXME Incompatible pointer when append
    this.append(new SystrayMenuStart());
    this.append(new SystrayMenuStatus());
    this.append(new SystrayMenuCheckIP());
    // FIXME when open dialog settings and use this from systray, app creates 2 dialogs. Must have 1 only
    this.append(new SystrayMenuSettings());
    this.append(new SystrayMenuQuit());
    this.show_all();
  }
}


public class AnonSurfStatusIcon: StatusIcon {
  private Gtk.Menu menu;
  private AnonSurfApp app;

  public AnonSurfStatusIcon(AnonSurfApp app) {
    this.app = app;
    this.menu = new AnonSurfSystrayMenu();
    this.set_from_icon_name("anonsurf");

    this.activate.connect(on_left_click_systray);
    this.popup_menu.connect(on_right_click_systray);
  }

  private void on_right_click_systray(uint button, uint time) {
    this.menu.popup(null, null, null, button, time);
  }

  private void on_left_click_systray() {
    this.app.activate();
  }
}
