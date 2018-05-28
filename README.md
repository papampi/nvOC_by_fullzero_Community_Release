# nvOC easy-to-use Linux Nvidia Mining OS
## Community Edition v2.1 (Beta Testing)
You can get nvOC running on your mining rig in two ways:
- Picking and burning a pre-built whole disk OS image (recommended)
- Cloning this repo on existing OS installations

### Pre-built images
Still no pre-built images available with nvOC 2.1+ (will come in future)
You can use old 2.0 images as base OS meanwhile and follow instructions in the section below to get nvOC 2.1+ installed. All needed instructions and links are on the old README for nvOC 2.0
1. Write the image with your favourite HDD image writer of choicce
2. Edit the nvOC configuration file named 1bash you can find in the small fat partition of rhe drive before booting for the first time. The same file contains settings descriptions that will help you completing the setup.

### Clone this repo
You can find all files needed to run nvOC in this repo but it's recommended you run nvOC from inside an old nvOC 2.0 pre-built image for optimal support. You may have issues trying to setup nvOC from repo on generic Ubuntu or other Linux distro installations.
1. Create a folder in a nice place on your drive and clone this repo into it

Starting from nvOC 2.1+ you can clone different versions of nvOC in different folder and keep all of them installed side-by-side for testing or evaluation purposes. However a single running nvOC instance is supported, you cannot run multiple ones at the same time. It's recommended you avoid cloning this repo directly into the user home directory

2. Setup your system to launch 2unix script from that folder on startup

Note that original nvOC startup method is based upon gnome-terminal profile. You can edit or disable this in termianl preferences.

3. Navigate to miners subfolder and fetch that submodule

The correct git revision is automatically selected, which is the default basic one for the main nvOC tree you cloned.

4. Run the nvOC_mienr_update.sh script to install the standard nvOC miner suite.

You can refer to https://github.com/papampi/nvOC_miners README for more help on how to update or enrich your miner collection in future

5. Edit nvOC configuration in 1bash file following contained instructions
