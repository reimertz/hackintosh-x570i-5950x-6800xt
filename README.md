# hackintosh-x570i-3950x
This repository contains Open-Core Utilities + EFI-folder for my Hackintosh build.
Dual-boot with Windows 10 and Cataline 10.15.6.

## Components

| Component | Model name | Count | Comment |
| -------- | ------------- | --- |  --- |
|	Motherboard | [Asus Strix GAMING X570-I](https://www.asus.com/Motherboards/ROG-Strix-X570-I-Gaming/) | 1 | *this motherboard has two M2 slots*|
| CPU | [AMD Ryzen 9 3950X](https://www.cpubenchmark.net/cpu.php?cpu=AMD+Ryzen+9+3950X&id=3598) | 1 | |
| PSU | [CORSAIR SF Series™ SF750](https://www.corsair.com/us/en/Categories/Products/Power-Supply-Units/Power-Supply-Units-Advanced/SF-Series/p/CP-9020186-NA) | 1 | |
| RAM | [VENGEANCE LPX 64GB (2 x 32GB) DDR4 DRAM 3200MHz C16 Memory Kit - Black](https://www.corsair.com/us/en/Categories/Products/Memory/VENGEANCE-LPX/p/CMK64GX4M2E3200C16) | 1 | |
| case | [Louqe Ghost s1](https://www.louqe.com/ghost-s1/) | 1 | |
| graphics card | [Radeon Vega 64](https://www.gigabyte.com/Graphics-Card/GV-RXVEGA64-8GD-B#kf) | 1 | |
| cooler | [Noctua NH-L12S](https://noctua.at/en/nh-l12s) | 1 | *this is a bit to big for my case so I cannot close it. get [this instead](https://noctua.at/en/nh-l12-ghost-s1-edition).* |
| SSD | [CORSAIR Force Series MP600 1 Tb](https://www.corsair.com/us/en/Categories/Products/Storage/M-2-SSDs/Force-Series%E2%84%A2-Gen-4-PCIe-NVMe-M-2-SSD/p/CSSD-F1000GBMP600) | 2 | *two because of dual-boot* |
| Bluetooth | [Asus BT400](https://www.asus.com/us/Networking/USBBT400/overview/) | 1 | |

Bluetooth Asus BT400

## Photos

<div>
<img src="/images/parts.jpeg" width="49%"/>
<img src="/images/done.jpeg" width="49%"/>
<p align="center"><i>banana is actually pretty small.. 🍌</i></p>
</div>

## What is working
- Undervolted + Underclocked vega 64
- Wake / sleep
- iCloud / Messages / Facetime
- Audio
- AirPods automatic switching
- USB (Apple Keyboard, Apple Trackpad)
- Ethernet
- Boot screen
- Dual boot

## What is NOT working (and probably never will)
- Built-in Wifi / Bluetooth (Intel®Wi-Fi 6 AX200)
- Virtualization (Docker, Android Emulator)

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
