Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33807 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbbAVV6e (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 22 Jan 2015 16:58:34 -0500
Received: by mail-wg0-f41.google.com with SMTP id a1so4297495wgh.0
        for <linux-wpan@vger.kernel.org>; Thu, 22 Jan 2015 13:58:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150122205920.GA18612@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
	<20150120194407.GB18226@omega>
	<CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
	<CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
	<54bf9983.07f4440a.7103.0a2e@mx.google.com>
	<20150121154634.GA664@omega>
	<CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
	<20150122205920.GA18612@omega>
Date: Thu, 22 Jan 2015 22:58:32 +0100
Message-ID: <CAFUtXGwkG7p-LLjRdV5fKrCLQMMVJzMDqBtG4Dt148xAKAm-XQ@mail.gmail.com>
Subject: Re: Device or resource busy
From: Maciej Wasilak <wasilak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Rohit Kulkarni <rmkulkar@gmail.com>, linux-wpan@vger.kernel.org

Hello,

2015-01-22 21:59 GMT+01:00 Alexander Aring <alex.aring@gmail.com>:
> can you please send the output of:
>
> `strace -f ifconfig wpan0 down`
>

pi@raspberrypi ~ $ sudo strace -f ifconfig wpan0 down
execve("/sbin/ifconfig", ["ifconfig", "wpan0", "down"], [/* 23 vars */]) = 0
brk(0)                                  = 0x2f9000
uname({sys="Linux", node="raspberrypi", ...}) = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb6fab000
access("/etc/ld.so.preload", R_OK)      = 0
open("/etc/ld.so.preload", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
mmap2(NULL, 44, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0xb6faa000
close(3)                                = 0
open("/usr/lib/arm-linux-gnueabihf/libcofi_rpi.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\270\4\0\0004\0\0\0"...,
512) = 512
lseek(3, 7276, SEEK_SET)                = 7276
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1080) = 1080
lseek(3, 7001, SEEK_SET)                = 7001
read(3, "A.\0\0\0aeabi\0\1$\0\0\0\0056\0\6\6\10\1\t\1\n\2\22\4\24\1\25"...,
47) = 47
fstat64(3, {st_mode=S_IFREG|0755, st_size=10170, ...}) = 0
mmap2(NULL, 39740, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb6f7e000
mprotect(0xb6f80000, 28672, PROT_NONE)  = 0
mmap2(0xb6f87000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb6f87000
close(3)                                = 0
munmap(0xb6faa000, 44)                  = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=56299, ...}) = 0
mmap2(NULL, 56299, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6f70000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabihf/libgcc_s.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0P\364\0\0004\0\0\0"...,
512) = 512
lseek(3, 129288, SEEK_SET)              = 129288
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1160) = 1160
lseek(3, 128956, SEEK_SET)              = 128956
read(3, "A2\0\0\0aeabi\0\1(\0\0\0\0056\0\6\6\10\1\t\1\n\2\22\4\24\1\25"...,
51) = 51
fstat64(3, {st_mode=S_IFREG|0644, st_size=130448, ...}) = 0
mmap2(NULL, 161780, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb6f48000
mprotect(0xb6f68000, 28672, PROT_NONE)  = 0
mmap2(0xb6f6f000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1f) = 0xb6f6f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/arm-linux-gnueabihf/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0(\0\1\0\0\0\230y\1\0004\0\0\0"...,
512) = 512
lseek(3, 1198880, SEEK_SET)             = 1198880
read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"...,
1360) = 1360
lseek(3, 1198444, SEEK_SET)             = 1198444
read(3, "A.\0\0\0aeabi\0\1$\0\0\0\0056\0\6\6\10\1\t\1\n\2\22\4\24\1\25"...,
47) = 47
fstat64(3, {st_mode=S_IFREG|0755, st_size=1200240, ...}) = 0
mmap2(NULL, 1242408, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) = 0xb6e18000
mprotect(0xb6f3b000, 28672, PROT_NONE)  = 0
mmap2(0xb6f42000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x122) = 0xb6f42000
mmap2(0xb6f45000, 9512, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6f45000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb6faa000
set_tls(0xb6faa4c0, 0xb6faab98, 0xb6fae048, 0xb6faa4c0, 0xb6fae048) = 0
mprotect(0xb6f42000, 8192, PROT_READ)   = 0
mprotect(0x1d000, 4096, PROT_READ)      = 0
mprotect(0xb6fad000, 4096, PROT_READ)   = 0
munmap(0xb6f70000, 56299)               = 0
brk(0)                                  = 0x2f9000
brk(0x31a000)                           = 0x31a000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2959760, ...}) = 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6c18000
mmap2(NULL, 1179648, PROT_READ, MAP_PRIVATE, 3, 0x1b3) = 0xb6af8000
close(3)                                = 0
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2570, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb6fa9000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2570
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb6fa9000, 4096)                = 0
open("/usr/lib/locale/en_US/LC_MESSAGES", O_RDONLY) = -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en/LC_MESSAGES", O_RDONLY) = -1 ENOENT (No such
file or directory)
uname({sys="Linux", node="raspberrypi", ...}) = 0
access("/proc/net", R_OK)               = 0
access("/proc/net/unix", R_OK)          = 0
socket(PF_FILE, SOCK_DGRAM, 0)          = 3
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 4
access("/proc/net/if_inet6", R_OK)      = 0
socket(PF_INET6, SOCK_DGRAM, IPPROTO_IP) = 5
access("/proc/net/ax25", R_OK)          = -1 ENOENT (No such file or directory)
access("/proc/net/nr", R_OK)            = -1 ENOENT (No such file or directory)
access("/proc/net/rose", R_OK)          = -1 ENOENT (No such file or directory)
access("/proc/net/ipx", R_OK)           = -1 ENOENT (No such file or directory)
access("/proc/net/appletalk", R_OK)     = -1 ENOENT (No such file or directory)
access("/proc/sys/net/econet", R_OK)    = -1 ENOENT (No such file or directory)
access("/proc/sys/net/ash", R_OK)       = -1 ENOENT (No such file or directory)
access("/proc/net/x25", R_OK)           = -1 ENOENT (No such file or directory)
ioctl(4, SIOCGIFFLAGS, {ifr_name="wpan0",
ifr_flags=IFF_UP|IFF_BROADCAST|IFF_RUNNING|IFF_NOARP}) = 0
ioctl(4, SIOCSIFFLAGS, {ifr_name="wpan0",
ifr_flags=IFF_BROADCAST|IFF_RUNNING|IFF_NOARP}) = 0
exit_group(0)                           = ?



> Additional please give more information about your ifconfig version, is
> it a busybox one? Ff yes then please tell us the busybox version.
>

ifconfig seems to be part of net-tools package - no mention of busybox anywhere:

pi@raspberrypi ~ $ dpkg -s net-tools
Package: net-tools
Status: install ok installed
Priority: important
Section: net
Installed-Size: 834
Maintainer: net-tools Team <pkg-net-tools-maintainers@lists.alioth.debian.org>
Architecture: armhf
Version: 1.60-24.2
Replaces: ja-trans (<= 0.8-2), netbase (<< 4.00)
Depends: libc6 (>= 2.13-28), libgcc1 (>= 1:4.4.0)
Conflicts: ja-trans (<= 0.8-2)
Description: The NET-3 networking toolkit
 This package includes the important tools for controlling the network
 subsystem of the Linux kernel.  This includes arp, ifconfig, netstat,
 rarp, nameif and route.  Additionally, this package contains utilities
 relating to particular network hardware types (plipconfig, slattach,
 mii-tool) and advanced aspects of IP configuration (iptunnel, ipmaddr).
 .
 In the upstream package 'hostname' and friends are included. Those are
 not installed by this package, since there is a special "hostname*.deb".
Homepage: http://net-tools.berlios.de/


Thanks for your help!
Maciek
