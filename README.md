# autohotkey-productivity-scripts

Collection of productivity, gaming, and accessibility AutoHotkey v2 scripts for cascading windows, APM counter GUI, and VIM-like controls. Feel free to use and distribute these scripts.

To download AutoHotkey, visit [http://www.autohotkey.com/](http://www.autohotkey.com/).
## Scripts

### [Cascade-Win.ahk](./Cascade-Win.ahk)
Provides functionality for managing and manipulating monitor information. A lot of AHK scripts are written in v1 and hard to understand.
- Retrieving monitor information
- Enumerating all monitors
- Getting monitor information from a window handle
- Cascading windows across monitors

### [APM-Counter.ahk](./APM-Counter.ahk)
Tracks your actions per minute (APM) and displays it in a GUI. Useful for high-APM games like League of Legends or StarCraft.
- Counting keyboard inputs
- Displaying APM in real-time
- Showing the input text in a scrollable box (TODO)

### [Vimium.ahk](./Vimium.ahk)
This script provides Vim-like keybindings and a crosshair navigation system, which can be useful for precise mouse movements similar to how people used to use the numpad. It uses a bisecting algorithm, allowing you to navigate with your cursor using quadrants. This can be particularly useful for people with difficulties using a mouse, as it enables more accurate and controlled cursor movements.

Still needs a lot of work. 
- Vim-like navigation using CapsLock key
- Crosshair navigation for precise mouse movements
- Switching between monitors
- Dragging and clicking with keyboard shortcuts

## How to Compile and Use

### Prerequisites
- [AutoHotkey v2](https://www.autohotkey.com/v2/) installed on your system.

### Running the Scripts
1. **Download the scripts**: Clone this repository or download the individual `.ahk` files.
2. **Run the scripts**: Double-click the `.ahk` files to run them with AutoHotkey v2.

### Compiling the Scripts
To compile the scripts into executable files:
1. **Open a terminal**: Navigate to the directory containing the `.ahk` files.
2. **Compile the script**: Use the following command to compile a script:
    ```sh
    Ahk2Exe.exe /in "script.ahk" /out "script.exe"
    ```
    Replace `script.ahk` with the name of the script you want to compile.

## TODOs

### [Cascade-Win.ahk](./Cascade-Win.ahk)
- [ ] Add more monitor management features.
- [ ] Improve error handling and logging.
- [ ] Optimize cascading algorithm for multi-monitor setups.

### [APM-Counter.ahk](./APM-Counter.ahk)
- [ ] Make the input text box dynamic and scrollable.
- [ ] Include mouse clicks in APM calculation.
- [ ] Add customizable hotkeys for starting and stopping the counter.

### [Vimium.ahk](./Vimium.ahk)
- [ ] Refactor crosshair into a separate class.
- [ ] Clear all GUIs drawn without reloading.
- [ ] Improve monitor switching logic.
- [ ] Add support for custom keybindings.
- [ ] Enhance crosshair navigation accuracy.

---