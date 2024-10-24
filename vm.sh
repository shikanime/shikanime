#!/bin/bash

qemu-system-aarch64 -M virt -cpu cortex-a72 \
  -m 256M -smp 2 -nographic \
  -bios QEMU_EFI.fd \
  -drive if=none,file=result/sd-image/nixos-sd-image-24.11.20240920.a1d9266-aarch64-linux.img.zst,id=hd0,format=raw -device virtio-blk-device,drive=hd0 \
  -device virtio-net-device,netdev=vmnic -netdev user,id=vmnic
