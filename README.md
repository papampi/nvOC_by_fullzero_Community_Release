# nvOC easy-to-use Linux Nvidia Mining OS (19-3.1 alpha)
Looking for Latest stable version? Go here: https://github.com/papampi/nvOC_by_fullzero_Community_Release/tree/19.2
## Community Edition - Quick start how-to
You can get nvOC running on your mining rig in some different ways:
- Picking and burning a pre-built whole disk OS image (recommended)
- Picking and burning a pre-built whole disk OS image targeting a beta testing branch
- Cloning this repo on existing OS installations

### Noob-proof: Pre-built images
Download the latest full nvOC OS image (links below), then:
1. Write the image with your favourite HDD image writer of choicce
2. Browse to the small fat partition you can see on the drive. Download the latest nvOC configuration file named '1bash.template' from latest 'release' [here](https://github.com/papampi/nvOC_by_fullzero_Community_Release/raw/release/1bash.tamplate) and save it there as '1bash'.
3. Edit this file with all your settings. The same file contains settings descriptions that will help you completing the setup.

### For insiders: Pre-built images targeting beta/pre-release branches
Download the latest full nvOC OS image, then:
1. Write the image with your favourite HDD image writer of choicce
2. Browse to the small fat partition you can see on the drive. Download the latest nvOC configuration file named '1bash.template' from your branch of choice in this repo and save it there as '1bash'.
3. Edit this file with all your settings. The same file contains settings descriptions that will help you completing the setup.
4. Edit the firstboot.json file in that same folder and put your selected branch name in place of the default release branch.

### For experts: Clone this repo
You can find all files needed to run nvOC in this repo but it's recommended you run nvOC from inside a pre-built nvOC image for optimal support. You may have issues trying to setup nvOC from repo on generic Ubuntu or other Linux distro installations.
1. Create a folder in a nice place on your drive and clone this repo into it, we suggest '~/NVOC/mining' but you are free to choose

Starting from nvOC 2.1+ you can clone different versions of nvOC in different folders and keep all of them installed side-by-side for actual 'mining', 'testing' or other purposes. However a single running nvOC instance is supported: you cannot run multiple ones at the same time. Please, avoid cloning this repo directly into the user home directory

2. Setup your system to launch 2unix script from that folder on startup

Note that original nvOC startup method is based upon gnome-terminal default profile. You can switch, edit or disable this in termianl preferences. There is also a beta support for running nvOC as a systemd service.

3. Update the miners submodule

Just do 'git submodule update --init --remote miners', the correct git revision is automatically selected, which is the one linked to the nvOC tree you cloned.

4. Run the nvOC_miner_update.sh script to install the standard nvOC miner suite.

You can refer to https://github.com/papampi/nvOC_miners README for more help on how to update or enrich your miner collection in future

5. Edit nvOC configuration in 1bash file following contained instructions

## Download pre-built OS images

### nvOC_V19-2.1beta_U16.04_N390_D180707 (for nvOC >= 2.1)
Version: always the latest, from configurable branch (default: [release](https://github.com/papampi/nvOC_by_fullzero_Community_Release/tree/release))

| host | size   | download                                                                       |
|------|--------|--------------------------------------------------------------------------------|
| MEGA | 3,50GB | [link](https://mega.nz/#!od1HGYjZ!kMp4ihj2TK81hNz6GkBR1--UkPhNf-JmdGHHEeDw3Ig) |

Checksums:

| file                                         | type   | value                                                            |
|----------------------------------------------|--------|------------------------------------------------------------------|
| nvOC_V19-2.1beta_U16.04_N390_D180707.img.zip | sha256 | 6334067606176ed90191b3e4980b21102d14a9c8f14ec63508669d1cb27d6e33 |
| nvOC_V19-2.1beta_U16.04_N390_D180707.img     | sha256 | f1f02c1cd704d3a33c954f64c5b6856f3a75612243b68d66da2fc9acd7bea8a5 |

### nvOC_V19-2.1beta_U16.04_N390_D180619
Version: beta testing snapshot branch [19-2.1@a3e92bd976997327fc971b549066f8a566781538](https://github.com/papampi/nvOC_by_fullzero_Community_Release/tree/a3e92bd976997327fc971b549066f8a566781538)

| host | size   | download                                                                       |
|------|--------|--------------------------------------------------------------------------------|
| MEGA | 3,43GB | [link](https://mega.nz/#!dNVTBIAC!7GGJpn9F-kehJOd1gW60CcR28BHTR3WMJxS7K-hd6Tg) |

Checksums:

| file                                         | type   | value                                                            |
|----------------------------------------------|--------|------------------------------------------------------------------|
| nvOC_V19-2.1beta_U16.04_N390_D180619.img.zip | sha256 | 7700dfdfc1cabab8a1dd9816a6322d6653c89943cb63afa59e79f88cfe14a6a9 |
| nvOC_V19-2.1beta_U16.04_N390_D180619.img     | sha256 | cb607c8e028d3bc0a0e274c34b4e0def0c71330053f0c8328120a717e0029938 |
