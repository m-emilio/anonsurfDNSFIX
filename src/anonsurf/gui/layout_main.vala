using Gtk;

const uchar button_size_x = 105;
const uchar button_size_y = 65;
const uchar button_boot_size_x = 60;
const uchar button_boot_size_y = 48;


public class LabelBootStatus: Label {
  public LabelBootStatus(bool is_enabled) {
    on_update_label(is_enabled);
  }

  public void on_update_label(bool boot_status) {
    if (boot_status == true) {
      this.set_label("Enabled");
    } else {
      this.set_label("Disabled");
    }
  }
}


public class LabelAnonSurfStatus: Label {
  public LabelAnonSurfStatus() { // TODO get the status from variable
    this.set_label("Deactivated");
  }
}


public class ButtonAnonSurfAction: Button {
  public ButtonAnonSurfAction() { // TODO get status from variable
    this.set_label("Start");
    this.set_size_request(button_size_x, button_size_y);
    this.clicked.connect(on_click_anonsurf_action);
  }

  private void on_click_anonsurf_action() {
    if (this.get_label() == "Start") {
      print("Starting\n");
    }
    else {
      print("Stopping\n");
    }
  }
}


public class ButtonChangeID: Button {
  public ButtonChangeID() { // TODO get status to disable / enable
    this.set_label("Change ID");
    this.set_size_request(button_size_x, button_size_y);
    this.clicked.connect(on_click_changeid);
  }

  private void on_click_changeid() {
    print("Changing id\n");
  }
}


public class ButtonRestart: Button {
  public ButtonRestart(bool anonsurf_status) { // TODO get status to disable / enable
    this.set_label("Restart");
    this.set_size_request(button_size_x, button_size_y);
    this.clicked.connect(on_click_restart);

    on_update_button(anonsurf_status);
  }

  private void on_click_restart() {
    print("Restarting\n");
  }

  public void on_update_button(bool anonsurf_status) {
    if (anonsurf_status == true) {
      this.set_sensitive(true);
    } else {
      this.set_sensitive(false);
    }
  }
}


public class ButtonMyIP: Button {
  public ButtonMyIP() {
    this.set_label("My IP");
    this.set_size_request(button_size_x, button_size_y);
    this.clicked.connect(on_click_myip);
  }

  private void on_click_myip() {
    print("Checking Public IP\n");
  }
}


public class ButtonBootAction: Button {
  public ButtonBootAction(bool is_enabled) {
    if (is_enabled == true) {
      this.set_label("Disable");
    }
    else {
      this.set_label("Enable");
    }

    this.set_size_request(button_boot_size_x, button_boot_size_y);
    this.clicked.connect(on_click_boot_action);
  }

  private void on_click_boot_action() {
    if (this.get_label() == "Enable") {
      print("Enabling boot\n");
    }
    else {
      print("Disabling boot\n");
    }
  }
}


public class ImageAnonSurfStatus: Image {
  public ImageAnonSurfStatus() { // TODO get status
    this.set_from_icon_name("security-medium", DIALOG);
  }
}


public class MainLayout: Box {
  private Label label_boot_status;
  private Label label_anonsurf_status;
  private Button button_anonsurf_actions; // Start or Stop anonsurf
  private Button button_change_id;
  private Button button_my_ip;
  private Button button_restart;
  private Button button_boot_actions;
  private Image image_status;

  private Box box_detail_area;
  private Box box_button_area;

  private Frame frame_boot_area;


  public MainLayout() {
    GLib.Object(orientation: Orientation.HORIZONTAL);

    init_all_objects();

    var box_extra_details = new Box(Orientation.VERTICAL, 3);

    box_extra_details.pack_start(box_detail_area, true, true, 3);
    box_extra_details.pack_start(frame_boot_area, false, true, 3);

    this.pack_start(box_extra_details, false, true, 3);
    this.pack_start(box_button_area, false, true, 1);
  }

  private void init_all_objects() {
    create_object_with_status();
    init_detail_area();
    init_boot_area();
    init_button_area();
  }

  private void init_detail_area() {
    box_detail_area = new Box(Orientation.HORIZONTAL, 3);

    box_detail_area.pack_start(this.image_status, false, true, 3);
    box_detail_area.pack_start(this.label_anonsurf_status, false, true, 3);
  }

  private void init_boot_area() {
    var box_boot_area = new Box(Orientation.HORIZONTAL, 3);
    frame_boot_area = new Frame("Boot status");

    box_boot_area.pack_start(this.label_boot_status, false, true, 3);
    box_boot_area.pack_start(this.button_boot_actions, false, true, 3);

    frame_boot_area.add(box_boot_area);
  }

  private void init_button_area() {
    box_button_area = new Box(Orientation.VERTICAL, 3);

    var box_button_upper = new Box(Orientation.HORIZONTAL, 3);
    var box_button_lower = new Box(Orientation.HORIZONTAL, 3);

    box_button_upper.pack_start(this.button_anonsurf_actions, false, true, 3);
    box_button_upper.pack_start(this.button_restart, false, true, 3);
    box_button_lower.pack_start(this.button_change_id, false, true, 3);
    box_button_lower.pack_start(this.button_my_ip, false, true, 3);

    box_button_area.pack_start(box_button_upper, false, true, 3);
    box_button_area.pack_start(box_button_lower, false, true, 3);
  }

  private void create_object_with_status() {

    bool anonsurf_status = is_anonsurf_running();
    bool tor_status = is_tor_running();
    bool anonsurf_boot_status = is_anonsurf_enabled_boot();

    label_boot_status = new LabelBootStatus(anonsurf_boot_status);
    label_anonsurf_status = new LabelAnonSurfStatus();
    button_anonsurf_actions = new ButtonAnonSurfAction();
    button_change_id = new ButtonChangeID();
    button_restart = new ButtonRestart(anonsurf_status);
    button_boot_actions = new ButtonBootAction(anonsurf_boot_status);
    button_my_ip = new ButtonMyIP();
    image_status = new ImageAnonSurfStatus();
  }

  public void on_update_layout(bool anonsurf_status, bool tor_status, bool anonsurf_boot_status) {
    //  label_boot_status.on_update_label(anonsurf_boot_status);
  }
}
