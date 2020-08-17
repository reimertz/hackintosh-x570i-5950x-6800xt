#!/usr/bin/env python
import sys, os, binascii, base64
from Scripts import *
if sys.version_info >= (3, 0):
    import tkinter as tk
    from tkinter import filedialog as fd
    from tkinter import messagebox as mb
else:
    import Tkinter as tk
    import tkFileDialog as fd
    import tkMessageBox as mb


class PyVega:
    def __init__(self, **kwargs):
        # Initialize the window and vars
        os.chdir(os.path.dirname(os.path.realpath(__file__)))
        self.i = ioreg.IOReg()
        self.default_gpu_path = "PciRoot(0x0)/Pci(0x1,0x0)/Pci(0x0,0x0)/Pci(0x0,0x0)/Pci(0x0,0x0)"
        self.config_values = {
            "PP_DisableClockStretcher": 1,
            "PP_DisablePowerContainment": 1,
            "PP_DisableULV": 1,
            "PP_EnableUploadFirmware": 0,
            "PP_Falcon_QuickTransition_Enable": 1,
            "PP_GfxOffControl": 0,
            "PP_PhmSoftPowerPlayTable": "",
            "PP_PhmUseDummyBackEnd": 0,
            "PP_ToolsLogSpaceSize": 524288
        }
        self.v = vega.Vega()
        self.window = tk.Tk()
        # self.window.configure(background="gray9")
        self.window.resizable(False, False)
        self.window.title(kwargs.get("title","PyVega"))
        w = kwargs.get("width",950)
        h = kwargs.get("height",720)
        # Let's also center the window
        x = self.window.winfo_screenwidth() // 2 - w // 2
        y = self.window.winfo_screenheight() // 2 - h // 2
        self.window.geometry("{}x{}+{}+{}".format(w,h, x, y))
        
        # Setup the card list
        self.vegas = {
            "Vega 64" : "vega64",
            "Vega 56" : "vega56",
            "Vega FE" : "vegafe",
            "Vega 64 Liquid Cooled" : "vega64_water",
            "Vega FE Liquid Cooled" : "vegafe_water",
            "Radeon Pro WX 8200" : "wx8200",
            "Radeon Pro WX 9100" : "wx9100"
        }

        # Setup the display list
        self.setting_list = [
            "Core Clock (MHz)",
            "Core Voltage (mV)",
            "Memory Clock (MHz)",
            "Memory Voltage (mV)"
        ]

        # Add the colors for each graphed line
        self.core_clock_color = "deep sky blue"
        self.core_voltage_color = "medium orchid"
        self.memory_clock_color = "orange red"
        self.mouse_over_color = "white smoke"
        self.memory_voltage_color = "light goldenrod"
        
        # And the color for the graph background
        self.graph_bg_color = "gray15"
        self.graph_line_color = "gray25"
        self.graph_text = "gray49"
        self.graph_w = 900.0
        self.graph_h = 300.0
        self.graph_xsteps = 8.0
        self.graph_ysteps = 21.0
        self.graph_xpad = 50.0
        self.graph_ypad = 35.0
        self.graph_xmin = 0.0
        self.graph_ymin = 0.0
        self.graph_xmax = 7.0
        self.graph_ymax = 2000.0
        
        # Create a list box with the available cards
        var = tk.StringVar(self.window)
        var.set("Vega 64")
        self.card_selected = "Vega 64"
        self.card_list = tk.OptionMenu(self.window, var, *sorted(self.vegas), command=self.select_vega)
        self.card_list.config(width=30)
        self.card_list.pack()

        # Pick the default card
        self.settings = self.v.select_type("vega64")

        # Draw the graph in the top portion of the window
        self.graph = tk.Canvas(self.window, height=self.graph_h, width=self.graph_w, background=self.graph_bg_color)
        self.graph.pack()

        # Let's give some more buttons and such
        var = tk.StringVar(self.window)
        var.set(self.setting_list[0])
        self.type_selected = var.get()
        self.type_dropbox = tk.OptionMenu(self.window, var, *self.setting_list, command=self.select_value)
        self.type_dropbox.config(width=30)
        self.type_dropbox.pack()

        # Create a placeholder for our sliders
        self.sliders = []
        self.slider_min = 100
        self.slider_max = 2000
        # Create the frame for our sliders
        self.slider_frame = tk.Frame(self.window, width = 1000)
        self.slider_frame.pack()

        # We need to create the fan sliders now
        self.f1 = tk.PhotoImage(file=os.path.join("Scripts","Fan1.gif"),format="gif")
        self.f2 = tk.PhotoImage(file=os.path.join("Scripts","Fan2.gif"),format="gif")
        self.f3 = tk.PhotoImage(file=os.path.join("Scripts","Fan3.gif"),format="gif")
        self.f1s = self.f1.subsample(4,4)
        self.f2s = self.f2.subsample(4,4)
        self.f3s = self.f3.subsample(4,4)

        self.fan_frame = tk.Frame(self.window, width=1000, height=100)
        self.fan1 = {"fan":tk.Label(self.fan_frame, image=self.f1s),"frame":1,"value":"minFan"}
        self.fan2 = {"fan":tk.Label(self.fan_frame, image=self.f1s),"frame":1,"value":"freeFan"}
        self.fan3 = {"fan":tk.Label(self.fan_frame, image=self.f1s),"frame":1,"value":"downFan"}
        self.fan4 = {"fan":tk.Label(self.fan_frame, image=self.f1s),"frame":1,"value":"maxFan"}
        self.spin_fan(self.fan1)
        self.spin_fan(self.fan2)
        self.spin_fan(self.fan3)
        self.spin_fan(self.fan4)
        self.fan1["fan"].pack(side="left", padx=6)
        self.fan2["fan"].pack(side="left", padx=6)
        self.fan3["fan"].pack(side="left", padx=6)
        self.fan4["fan"].pack(side="left", padx=6)
        self.fan_frame.pack()

        # We need fan sliders now!
        self.fan_s_frame = tk.Frame(self.window, width=1000, height=100)
        self.fs1 = tk.Scale(self.fan_s_frame, from_=200, to=4900, label="Min Speed", orient=tk.HORIZONTAL, command=lambda x: self.min_fan(x))
        self.fs1.set(self.settings["defaults"].get("minFan",200))
        self.fs1.pack(side="left")
        self.fs2 = tk.Scale(self.fan_s_frame, from_=200, to=4900, label="Idle Speed", orient=tk.HORIZONTAL, command=lambda x: self.free_fan(x))
        self.fs2.set(self.settings["defaults"].get("freeFan",200))
        self.fs2.pack(side="left")
        self.fs3 = tk.Scale(self.fan_s_frame, from_=200, to=4900, label="Target Speed", orient=tk.HORIZONTAL, command=lambda x: self.down_fan(x))
        self.fs3.set(self.settings["defaults"].get("downFan",200))
        self.fs3.pack(side="left")
        self.fs4 = tk.Scale(self.fan_s_frame, from_=200, to=4900, label="Max Speed", orient=tk.HORIZONTAL, command=lambda x: self.max_fan(x))
        self.fs4.set(self.settings["defaults"].get("maxFan",200))
        self.fs4.pack(side="left")
        self.fan_s_frame.pack()

        self.fs5 = tk.Scale(self.window, from_=100, to=7000, label="Fan Sensitivity", orient=tk.HORIZONTAL, command=lambda x: self.fan_sens(x))
        self.fs5.set(self.settings["defaults"].get("senFan",4836))
        self.fs5.pack()

        # Add the Target Temp and TDC% Sliders
        self.temp_frame = tk.Frame(self.window, width=1000,height=100)
        self.temp_target = tk.Scale(self.temp_frame, from_=10, to=100, label="TempGoal (C)", orient=tk.HORIZONTAL, command=lambda x: self.temp_slider(x))
        self.temp_target.set(self.settings["defaults"].get("tempLine",70))
        self.temp_target.pack(side="left")
        self.power_target = tk.Scale(self.temp_frame, from_=10, to=150, label="TDC (%)", orient=tk.HORIZONTAL, command=lambda x: self.power_slider(x))
        self.power_target.set(self.settings["defaults"].get("power",50))
        self.power_target.pack(side="left")
        self.temp_frame.pack()

        # Add the Defaults, and Save buttons - as well as the OC Checkbox
        self.default_button = tk.Button(self.window, text="Reset to Defaults", command=self.defaults)
        self.default_button.pack(side="left",padx=15)
        self.save_button = tk.Button(self.window, text="Select Target Config.plist", command=self.save)
        self.save_button.pack(side="left",padx=6)
        self.chk = tk.IntVar()
        self.chk.set(0)
        self.checkbox = tk.Checkbutton(self.window, variable=self.chk, onvalue=1, offvalue=0, text="Enable OC (Disables Total Power In Watts Sensor)")
        self.checkbox.pack(side="left",padx=6)


        self.select_value(self.type_selected)
        self.update()
        self.window.mainloop()

    def ensure(self, path_list, dict_data):
        item = dict_data
        for path in path_list:
            if not path in item:
                item[path] = {}
            item = item[path]
        return dict_data

    def save(self):
        # Let's get the hex!
        # self.v.selected = self.settings
        hex_data = self.v.dump_hex()
        base64_data = binascii.unhexlify(hex_data.encode("utf-8"))
        if sys.version_info < (3, 0):
            import plistlib
            base64_data = plistlib.Data(base64_data)
        # Set the appropriate fields
        self.config_values["PP_DisablePowerContainment"] = self.chk.get()
        self.config_values["PP_PhmSoftPowerPlayTable"] = base64_data
        # Get our config.plist path
        f = fd.askopenfilename(title = "Select config.plist",filetypes=[("Plist files", "*.plist")])
        if not len(f):
            # User cancelled
            return
        # At this point - we want to open the file, make sure it's formatted correctly,
        try:
            with open(f,"rb") as a:
                plist_data = plist.load(a)
        except Exception as e:
            mb.showerror("Malformed Plist", str(e))
            return
        # locate our dGPU, then add it in the properties
        gpu_path = None
        defaulted_on_path = False
        if sys.platform == "darwin":
            # We have macOS - let's find our dGPU - or at least attempt to
            gpu_devices = self.i.get_devices(" GFX")
            if len(gpu_devices):
                gpu_path = self.i.get_device_path(gpu_devices[0])
        if not gpu_path:
            gpu_path = self.default_gpu_path
            defaulted_on_path = True
        # Now we walk our config and make sure we add whatever we need
        plist_data = self.ensure(["Devices","Properties",gpu_path],plist_data)
        if len(plist_data["Devices"]["Properties"][gpu_path]):
            # We already have some values here
            if not mb.askyesno("Data Exists!", "Data already exists for {}, add anyway?".format(gpu_path)):
                return
        # At this point - we should be ready to write!
        for x in self.config_values:
            plist_data["Devices"]["Properties"][gpu_path][x] = self.config_values[x]
        # Should be done now - let's save it
        try:
            with open(f,"wb") as a:
                plist.dump(plist_data, a)
        except Exception as e:
            mb.showerror("Save Error", str(e))
            return
        # If we got this far - let's build a message and show the user
        mb.showinfo("Plist Saved","Saved data for {}{} to {}.".format(gpu_path, " (Default)" if defaulted_on_path else "", f))

    def defaults(self):
        self.settings = self.v.select_type(self.vegas[self.card_selected])
        self.select_value(self.type_selected)
        self.chk.set(0)
        self.reset_fans()
        self.update()

    def reset_fans(self):
        self.fs1.set(self.settings["defaults"].get("minFan",200))
        self.fs2.set(self.settings["defaults"].get("freeFan",200))
        self.fs3.set(self.settings["defaults"].get("downFan",200))
        self.fs4.set(self.settings["defaults"].get("maxFan",200))
        self.fs5.set(self.settings["defaults"].get("senFan",4836))
        self.temp_target.set(self.settings["defaults"].get("tempLine",70))
        self.power_target.set(self.settings["defaults"].get("power",50))

    def temp_slider(self, value):
        self.settings["defaults"]["tempLine"] = value
        self.update()

    def power_slider(self, value):
        self.settings["defaults"]["power"] = value
        self.update()

    def fan_sens(self, value):
        self.settings["defaults"]["senFan"] = value
        self.update()

    def min_fan(self, value):
        self.settings["defaults"]["minFan"] = value
        self.update()

    def free_fan(self, value):
        self.settings["defaults"]["freeFan"] = value
        self.update()

    def down_fan(self, value):
        self.settings["defaults"]["downFan"] = value
        self.update()

    def max_fan(self, value):
        self.settings["defaults"]["maxFan"] = value
        self.update()

    def spin_fan(self, fan):
        # Get speed first
        speed = self.settings["defaults"].get(fan["value"])
        # Speed is 200 rpm to 4900
        final = float(speed)/1000 # get the value as a float 0 through 1
        fan["frame"]+=1
        if fan["frame"] >= 4:
            fan["frame"] = 1
        # Set the new image
        fan["fan"].configure(image=getattr(self,"f{}s".format(fan["frame"])))
        self.window.after(int(1/final*100), lambda fan=fan: self.spin_fan(fan))

    def update(self):
        # Do our updating here - make sure all buttons and things
        # correspond to their selections
        self.draw_graph()
        try:
            color = [
                self.core_clock_color,
                self.core_voltage_color,
                self.memory_clock_color,
                self.memory_voltage_color
            ][self.setting_list.index(self.type_selected)]
        except:
            color = self.core_clock_color
        self.type_dropbox.config(bg=color)

    def select_value(self,value):
        self.type_selected = value
        # We need to update our sliders
        mem_c = {"color":self.memory_clock_color,"points":[]}
        cor_c = {"color":self.core_clock_color,"points":[]}
        cor_v = {"color":self.core_voltage_color,"points":[]}
        for x in self.settings["defaults"]:
            i = {"name":x,"value":self.settings["defaults"][x]}
            if x.endswith("cf"):
                cor_c["points"].append(i)
            elif x.endswith("cv"):
                cor_v["points"].append(i)
            elif x.endswith("mf"):
                mem_c["points"].append(i)
            else:
                # Don't know it, skip
                continue
        # Check which we're actually doing
        our_list = []
        if value == "Core Clock (MHz)":
            our_list = cor_c["points"]
        elif value == "Core Voltage (mV)":
            our_list = cor_v["points"]
        elif value == "Memory Clock (MHz)":
            our_list = mem_c["points"]
        elif value == "Memory Voltage (mV)":
            our_list = [{"name":"P3mv","value":self.settings["defaults"].get("P3mv",0)}]
        else:
            return # wut just happened??
        
        # Clear out all previous buttons
        for x in self.sliders:
            try:
                x["slider"].destroy()
            except:
                pass
        
        # Add new sliders
        for i,x in enumerate(sorted(our_list, key=lambda x:x["name"])):
            w = tk.Scale(self.slider_frame, label=x["name"], from_=self.slider_min, to=self.slider_max, orient=tk.HORIZONTAL, command=lambda i=i,x=x: self.slider_moved(i,x))
            w.set(x["value"])
            w.pack(side="left")
            self.sliders.append({"slider":w,"value":x})
        self.reset_fans()
        self.update()

    def slider_moved(self,index,value):
        # Get the name - and save the new value - then update
        self.settings["defaults"][value["name"]] = float(index)
        self.update()

    def select_vega(self,value):
        self.card_selected = value
        self.settings = self.v.select_type(self.vegas[self.card_selected])
        self.select_value(self.type_selected)
        self.reset_fans()
        self.update()

    def get_x(self, x):
        # Get the total width after padding
        total_w = self.graph_w - (self.graph_xpad*2)
        # Cut x by the min value
        x -= self.graph_xmin
        # Get the current step + the pad
        return (x/self.graph_xmax*total_w)+self.graph_xpad

    def get_y(self, y):
        # Get the total height after padding
        total_h = self.graph_h - (self.graph_ypad*2)
        # Cut x by the min value
        y -= self.graph_ymin
        # Get the current step + the pad
        return self.graph_h-(y/self.graph_ymax*total_h+self.graph_ypad)

    def draw_graph(self):
        # Remove anything that's there already
        self.graph.delete("all")

        # Draw the graph border
        self.graph.create_line(
            self.get_x(self.graph_xmin),
            self.get_y(self.graph_ymin),
            self.get_x(self.graph_xmax),
            self.get_y(self.graph_ymin),
            self.get_x(self.graph_xmax),
            self.get_y(self.graph_ymax),
            self.get_x(self.graph_xmin),
            self.get_y(self.graph_ymax),
            self.get_x(self.graph_xmin),
            self.get_y(self.graph_ymin),
            fill=self.graph_line_color,
            width=3
            )

        # Draw the vertical lines
        for z in range(int(self.graph_xsteps)):
            x1 = x2 = self.get_x(z)
            y1 = self.get_y(self.graph_ymin)
            y2 = self.get_y(self.graph_ymax)
            self.graph.create_line(x1, y1, x2, y2, fill=self.graph_line_color)
            # Draw the label
            self.graph.create_text(x1, self.get_y(0)+self.graph_ypad/2, fill=self.graph_text, text="P{}".format(z))
        # Draw the horizontal lines - we're going to skip every other
        for z in range(int(self.graph_ysteps)):
            y1 = y2 = self.get_y(z*100)
            x1 = self.get_x(self.graph_xmin)
            x2 = self.get_x(self.graph_xmax)
            self.graph.create_line(x1, y1, x2, y2, fill=self.graph_line_color)
            # Draw the label
            if z % 2 == 0:
                self.graph.create_text(self.get_x(0)-self.graph_xpad/2, y1, fill=self.graph_text, text="{}".format(z*100))

        mem_c = {"color":self.memory_clock_color,"points":[]}
        cor_c = {"color":self.core_clock_color,"points":[]}
        cor_v = {"color":self.core_voltage_color,"points":[]}
        for x in self.settings["defaults"]:
            i = {"name":x,"value":self.settings["defaults"][x]}
            if x.endswith("cf"):
                cor_c["points"].append(i)
            elif x.endswith("cv"):
                cor_v["points"].append(i)
            elif x.endswith("mf"):
                mem_c["points"].append(i)
            else:
                # Don't know it, skip
                continue
        # Let's sort the values - start with the memory voltage
        mem = self.get_y(self.settings["defaults"].get("P3mv",0))
        self.graph.create_line(self.get_x(self.graph_xmin), mem, self.get_x(self.graph_xmax), mem, fill=self.memory_voltage_color, activefill=self.mouse_over_color, width=4)
        # Now do the rest
        for x in [mem_c, cor_c, cor_v]: 
            x["points"] = sorted(x["points"], key=lambda x:x["name"])
            point_list = []
            for y,z in enumerate(sorted(x["points"], key=lambda x:x["name"])):
                # Gather our points - enumerate for X axis
                line_x = self.get_x(y)
                line_y = self.get_y(z["value"])
                point_list.append(line_x)
                point_list.append(line_y)
                # Draw each point
                self.graph.create_oval(line_x-4, line_y-4, line_x+4, line_y+4, fill=x["color"])
            # Draw them!
            self.graph.create_line(*point_list, width=4, fill=x["color"], activefill=self.mouse_over_color)

p = PyVega()
