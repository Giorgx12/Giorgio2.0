$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

$nasm = Join-Path $env:LOCALAPPDATA "bin\NASM\nasm.exe"
$zig = Get-Command zig.exe -ErrorAction SilentlyContinue
$objcopy = Get-Command objcopy.exe -ErrorAction SilentlyContinue
$qemu = Get-Command qemu-system-i386.exe -ErrorAction SilentlyContinue

if (-not (Test-Path $nasm)) { throw "NASM non trovato: $nasm" }
if (-not $zig) { throw "Zig non trovato nel PATH" }
if (-not $objcopy) { throw "objcopy non trovato nel PATH" }
if (-not $qemu) { throw "QEMU non trovato nel PATH" }

Write-Host "[1/7] Assemblo boot.asm..."
& $nasm -f bin .\boot.asm -o .\boot.bin

Write-Host "[2/7] Assemblo kernel_entry.asm..."
& $nasm -f elf32 .\kernel_entry.asm -o .\kernel_entry.o

Write-Host "[3/7] Assemblo porte.asm..."
& $nasm -f elf32 .\porte.asm -o .\porte.o

Write-Host "[4/7] Compilo kernel-old.cpp..."
& $zig.Source c++ -target x86-freestanding -ffreestanding -fno-exceptions -fno-rtti -fno-sanitize=undefined -c .\kernel-old.cpp -o .\kernel-old.o

Write-Host "[5/7] Collego kernel..."
& $zig.Source c++ -target x86-freestanding -nostdlib -fno-exceptions -fno-rtti -fuse-ld=lld "-Wl,-T,.\linker.ld" -o .\kernel-old.elf .\kernel_entry.o .\porte.o .\kernel-old.o

Write-Host "[6/7] Creo immagine..."
& $objcopy.Source -O binary .\kernel-old.elf .\kernel-old.bin
$kernel = [IO.File]::ReadAllBytes(".\kernel-old.bin")
$sectors = [Math]::Ceiling($kernel.Length / 512)
if ($sectors -gt 6) { throw "kernel-old.bin supera i 6 settori supportati da boot.asm" }
$aligned = New-Object byte[] (6 * 512)
[Array]::Copy($kernel, $aligned, $kernel.Length)
[IO.File]::WriteAllBytes(".\kernel-old.bin", $aligned)
$boot = [IO.File]::ReadAllBytes(".\boot.bin")
[IO.File]::WriteAllBytes(".\os-old-image.bin", $boot + $aligned)

Write-Host "[7/7] Avvio QEMU..."
& $qemu.Source -drive "file=.\os-old-image.bin,format=raw,if=ide" -boot order=c
