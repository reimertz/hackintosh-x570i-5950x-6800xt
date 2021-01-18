# hackintosh-x570i-5950x
This repository contains Open-Core Utilities + EFI-folder for my Hackintosh build.
Dual-boot with Windows 10 and Big Sur 11.16. 

A lot of love to [ChanceArthur](https://github.com/ChanceArthur) and his [article](https://chancearthur.com/notes/macos-on-the-asus-rog-strix-x570-i) that helped me getting a stable build. 

<div>

<img src="/images/AAEB3BF7-CE5F-41A6-A29C-5E3952518C23_1_105_c.jpeg" width="49%"/>
<img src="/images/parts.jpeg" width="49%"/>

<p align="center"><i>banana is actually pretty small.. 🍌</i></p>

<img src="/images/pump_cover_1.jpeg" width="49%"/>
<img src="/images/pump_cover_2.jpeg" width="49%"/>

<p align="center"><i>custom 3d-printed cover for the pump. also repainted the PSU fan.</i></p>

<img src="/images/smiley.jpg" width="49%"/>

<p align="center"><i>Replaced fugly ROG-eye with custom 3D-printed cover</i></p>
</div>

## Components

| Component | Model name | Count | Comment |
| -------- | ------------- | --- |  --- |
| Case | [Louqe Ghost s1 ](https://www.louqe.com/ghost-s1/) | 1 | |
| Case | [Louqe Ghost s1 Large Tophat ](https://www.louqe.com/accessories/#tophatbanner) | 2 | |
|	Motherboard | [Asus Strix GAMING X570-I](https://www.asus.com/Motherboards/ROG-Strix-X570-I-Gaming/) | 1 | *this motherboard has two M2 slots*|
| CPU | [AMD Ryzen 9 5950X](https://www.amd.com/en/products/cpu/amd-ryzen-9-5950x) | 1 | |
| PSU | [CORSAIR SF Series™ SF750](https://www.corsair.com/us/en/Categories/Products/Power-Supply-Units/Power-Supply-Units-Advanced/SF-Series/p/CP-9020186-NA) | 1 | 
| RAM | [G.Skill Trident Z Neo DDR4-3600MHz CL16-19-19-39 1.35V 32GB (2x16GB)](https://www.gskill.com/product/165/326/1562840211/F4-3600C16D-32GTZNCTrident-Z-NeoDDR4-3600MHz-CL16-19-19-39-1.35V32GB-(2x16GB)) | 1 | |
| NVRAM | [CORSAIR Force Series MP600 1 Tb](https://www.corsair.com/us/en/Categories/Products/Storage/M-2-SSDs/Force-Series%E2%84%A2-Gen-4-PCIe-NVMe-M-2-SSD/p/CSSD-F1000GBMP600) | 2 | *two because of dual-boot* |
| Graphics card | [Radeon 6800 XT](https://www.amd.com/en/products/graphics/amd-radeon-rx-6800-xt) | 1 | *still waiting for drivers :( * |
| GPU water-block | [EK-Quantum Vector RX 6800/6900 D-RGB - Nickel + Plexi](https://www.ekwb.com/shop/ek-quantum-vector-rx-6800-6900-d-rgb-nickel-plexi) | 1 | *still waiting for drivers :( * |
| GPU water-block backplate | [EK-Quantum Vector RX 6800/6900 Backplate - Nickel](https://www.ekwb.com/shop/ek-quantum-vector-rx-6800-6900-backplate-nickel) | 1 | * bonus feature: this enables adding thermal pads between gpu and second NVRAM * |
https://www.ekwb.com/shop/ek-quantum-vector-rx-6800-6900-d-rgb-nickel-plexi
| Wifi + Bluetooth | [Apple Airport BCM94360CD](https://www.ebay.com/itm/Apple-iMac-A1418-A1419-WiFi-Wireless-WLAN-Adapter-Card-Airport-BCM94360CD-W54/293691980043?ssPageName=STRK%3AMEBIDX%3AIT&_trksid=p2060353.m2749.l2649) | 1 | |
| CPU water-block | [EK AMD Velocity D-RGB Nickel](https://www.ekwb.com/shop/ek-quantum-velocity-d-rgb-amd-nickel-plexi) | 1 | |
| Radiator | [Alphacool NexXxoS ST30 Full Copper 240mm radiator V.2](https://www.alphacool.com/shop/radiators/active-radiators/23667/alphacool-nexxxos-st30-full-copper-240mm-radiator-v.2) | 1 | |
| Radior fans | [Noctua NF-A12x25](https://noctua.at/en/products/fan/nf-a12x25-pwm) | 2 | |
| Pump | [Alphacool DC-LT 2600 Ultra low noise Ceramic](https://www.alphacool.com/shop/pumps/alphacool-pumps/20729/alphacool-dc-lt-2600-ultra-low-noise-ceramic-12v-dc) | 1 | |
| Reservoir | [Alphacool Eisstation 40 DC-LT](https://www.alphacool.com/shop/reservoirs/pump-top-reservoirs/24196/alphacool-eisstation-40-dc-lt-reservoir) | 1 | |
| Cable Fittings | [EK-Quantum Torque 6-Pack STC 10/16](https://www.ekwb.com/shop/ek-quantum-torque-6-pack-stc-10-16-black) | 1 pack (6 fittings)| |
| 90° angled adapter (for pump)| [EK-AF Classic Angled 90° - Black](https://www.ekwb.com/shop/ek-af-classic-angled-90-black) | 1 |
| 45°+45° angled adapter (for cpu)| [EK-AF Angled 2×45° G1/4 Black](https://www.ekwb.com/shop/ek-af-angled-2-45-g1-4-black) | 2 |
| Tube | [EK-Tube ZMT Matte Black 15,9/9,5mm](https://www.ekwb.com/shop/ek-tube-zmt-matte-black-15-9-9-5mm-3m-retail) | 1 |



## What is working
- Undervolted + Underclocked vega 64
- Wake / sleep
- iCloud / Messages / Facetime 
- Airdrop
- Audio
- AirPods automatic switching
- USB (Apple Keyboard, Apple Trackpad)
- Native Wifi + Bluetooth functionality thanks to BCM94360CD
- Bluetooth functionality in Bios and Bootloader(Apple Keyboard, Apple Trackpad)
- Ethernet
- Dual boot

## What is NOT working (and probably never will)
- Virtualization (Docker, Android Emulator)
- Line-in microphone
