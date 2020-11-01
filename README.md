# hackintosh-x570i-3950x
This repository contains Open-Core Utilities + EFI-folder for my Hackintosh build.
Dual-boot with Windows 10 and Cataline 10.15.6.

<div>
<img src="/images/AAEB3BF7-CE5F-41A6-A29C-5E3952518C23_1_105_c.jpeg" width="49%"/>
  <img src="/images/parts.jpeg" width="49%"/>
    <img src="/images/pump_cover_1.jpeg" width="49%"/>
      <img src="/images/pump_cover_2.jpeg" width="49%"/>
         <img src="/images/smiley.jpg" width="49%"/>
<p align="center"><i>banana is actually pretty small.. 🍌</i></p>
</div>

## Components

| Component | Model name | Count | Comment |
| -------- | ------------- | --- |  --- |
| Case | [Louqe Ghost s1 + topcase](https://www.louqe.com/ghost-s1/) | 1 | |
|	Motherboard | [Asus Strix GAMING X570-I](https://www.asus.com/Motherboards/ROG-Strix-X570-I-Gaming/) | 1 | *this motherboard has two M2 slots*|
| CPU | [AMD Ryzen 9 3950X](https://www.cpubenchmark.net/cpu.php?cpu=AMD+Ryzen+9+3950X&id=3598) | 1 | |
| PSU | [CORSAIR SF Series™ SF750](https://www.corsair.com/us/en/Categories/Products/Power-Supply-Units/Power-Supply-Units-Advanced/SF-Series/p/CP-9020186-NA) | 1 | 
| RAM | [VENGEANCE LPX 64GB (2 x 32GB) DDR4 DRAM 3200MHz C16 Memory Kit - Black](https://www.corsair.com/us/en/Categories/Products/Memory/VENGEANCE-LPX/p/CMK64GX4M2E3200C16) | 1 | |
| SSD | [CORSAIR Force Series MP600 1 Tb](https://www.corsair.com/us/en/Categories/Products/Storage/M-2-SSDs/Force-Series%E2%84%A2-Gen-4-PCIe-NVMe-M-2-SSD/p/CSSD-F1000GBMP600) | 2 | *two because of dual-boot* |
| Graphics card | [Radeon Vega 64](https://www.gigabyte.com/Graphics-Card/GV-RXVEGA64-8GD-B#kf) | 1 | *waiting for [Big Navi](https://duckduckgo.com/?q=amd+big+navi&t=ffab&iar=news&ia=news) so used my already owned vega 64 from a previous EGPU build* |
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

## Cost Efficiency

I  want to acknowledge that I am privileged to be able to spend this on a  build but it is very motivated since I work on this thing for 8 hours a  day.
It might not be obvious, but I  am saving a lot of money by investing in this. If you split this cost  over 5 years, it's $2 a day[0]. 

I rather pay that premium to have faster  Xcode builds, faster git cloning, faster render times, faster exports  etc while also buying parts thate are future-proofed.

Actually,  let's say I'd save 10 minutes a day and had a salary of $25/hour, this computer would pay itself. [1]

[0]:
Cost of computer / # of days I work in 5 years = Cost/day
$2500 / (5 days * 50 weeks * 5 years) = $2/day

[1]:
Salary / min * mins saved / day *  nr of days in 5 years = $ saved
($25 / 60 min)  * 10 min * ( 5 dys * 50 weeks * 5 years) = $2604 saved
