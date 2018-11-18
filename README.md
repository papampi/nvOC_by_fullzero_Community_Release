# nvOC easy-to-use Linux Nvidia Mining OS
This page is about the Latest stable version of nvOC Community Edition
## Community Edition - Quick start how-to
You can get nvOC running on your mining rig in some different ways:
- Picking and burning a pre-built whole disk OS image (recommended)
- Picking and burning a pre-built whole disk OS image targeting a beta testing branch
- Cloning this repo on existing OS installations

### Noob-proof: Pre-built images
Download the latest full nvOC OS image (links below), then:
1. Write the image with your favourite HDD image writer of choicce
2. Browse to the small fat partition you can see on the drive. Download the latest nvOC configuration file named '1bash.template' from latest 'release' [here](https://raw.githubusercontent.com/papampi/nvOC_by_fullzero_Community_Release/release/1bash.template) and save it there as '1bash'.
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

### nvOC_19-3.x, Ubuntu 16.04, Dual-Cuda 8+9.2, Nvidia 410, 2018-10-27 (for nvOC >= 2.1)
Version: always the latest, from configurable branch (default: [release](https://github.com/papampi/nvOC_by_fullzero_Community_Release/tree/release))

| host | size   | download                                                                       |
|------|--------|--------------------------------------------------------------------------------|
| MEGA | 3,8 GB | [link](https://mega.nz/#!VYl0yIab!TWctArrWrr2euuHRm2C8lgAE7COYAvTWwWRmdiAQNsE) |
| GDrive | 3,8 GB | [link](https://drive.google.com/file/d/1-NbKJBOYJwVA3iqnbVY1pRs0wPr5Gc-X/view?usp=drivesd)  |
| OneDrive | 3,8 GB | [link](https://polimi365-my.sharepoint.com/:u:/g/personal/10434559_polimi_it/EQruOF1Zu0ZNqPvaA68818MB-EFQGivU_zCBTCHD5j_N6g?e=WKBYsC)|

Checksums:

| file                                                 | type   | value                                                            |
|------------------------------------------------------|--------|------------------------------------------------------------------|
| nvOC_19-3.x_U16.04_Cuda_8-9.2_N410_2018-10-27.7z      | sha256 | 95faf1267ad196bd4f70a47929f0a1b32e7bc9b7095879a0e87ad44c2dd9650f |
| nvOC_19-3.x_U16.04_Cuda_8-9.2_N410_2018-10-27.img    | sha256 | b9f4d01b487772231df593966c5e5e4368ed881a4112d7c6708f60de3660b1d6 |


### nvOC_19-2.1 beta Ubuntu 18.04 Dual-Cuda Nvidia 396 2018-09-07 (for nvOC >= 2.1)
Version: always the latest, from configurable branch (default: [release](https://github.com/papampi/nvOC_by_fullzero_Community_Release/tree/release))

Note: Ubuntu 18.04 may have some conflicts with tempcontrol

| host | size   | download                                                                       |
|------|--------|--------------------------------------------------------------------------------|
| MEGA | 3,61GB | [link](https://mega.nz/#!BFthBShR!88rChE-cQRJM30n021x9HTGJjFav8VPTuTUci4KXHXM) |
| GDrive | 3,61GB | [link](https://drive.google.com/open?id=1Gl_h8aGGNzC-XXhmEHavHWJXfKFMU90R)   |
| OneDrive | 3,61GB | [link](https://bit.ly/2Qjqr33)                                             |

Checksums:

| file                                                 | type   | value                                                            |
|------------------------------------------------------|--------|------------------------------------------------------------------|
| nvOC_19-2.1_U18.04_Dual-Cuda_N396_2018-09-05.7z      | sha256 | 2384B639142123F13D9E8BAE834F248A293F4F7142B05D5CBF55FBE2DBCB6903 |
| nvOC_19-2.1_U18.04_Dual-Cuda_N396_2018-09-05.img     | sha256 | 27090E4CF4C4928619AFE456995870F9FAC0996F7876B7791898BD18F2B21D00 |


### nvOC_V19-2.1beta_U16.04_N390_D180707 (for nvOC >= 2.1)
Version: always the latest, from configurable branch (default: [release](https://github.com/papampi/nvOC_by_fullzero_Community_Release/tree/release))

| host | size   | download                                                                       |
|------|--------|--------------------------------------------------------------------------------|
| MEGA | 3,50GB | [link](https://mega.nz/#!od1HGYjZ!kMp4ihj2TK81hNz6GkBR1--UkPhNf-JmdGHHEeDw3Ig) |
| GDrive | 3,50GB | [link](https://drive.google.com/folderview?id=1B0G83ZQm6a7-5irzBSo7YrYyk353HtIg) |

Checksums:

| file                                         | type   | value                                                            |
|----------------------------------------------|--------|------------------------------------------------------------------|
| nvOC_V19-2.1beta_U16.04_N390_D180707.img.zip | sha256 | 6334067606176ed90191b3e4980b21102d14a9c8f14ec63508669d1cb27d6e33 |
| nvOC_V19-2.1beta_U16.04_N390_D180707.img     | sha256 | f1f02c1cd704d3a33c954f64c5b6856f3a75612243b68d66da2fc9acd7bea8a5 |

