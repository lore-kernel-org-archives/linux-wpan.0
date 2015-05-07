Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:58370 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbbEGKlT (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 06:41:19 -0400
Received: from [10.4.18.104] ([77.89.145.139]) by mrelayeu.kundenserver.de
 (mreue103) with ESMTPSA (Nemesis) id 0MRzqc-1YejiB0R8E-00TGiJ for
 <linux-wpan@vger.kernel.org>; Thu, 07 May 2015 12:41:17 +0200
Message-ID: <554B414B.50408@xsilon.com>
Date: Thu, 07 May 2015 11:41:15 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Oops with latest bluetooth-next kernel.
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hi,

I've recently upgraded my kernel to bluetooth-net-next with the latest lrwpan-tools and find that I get the following Oops:

We have 3 wpan interfaces, a powerline, a wireless, and a fakelb interface.  If I disable the wireless interface everything is fine.  If I disable the fakelb interface all is well.  The problem seems to be when all 3 interfaces are up.   This used to work in our 3.16 Kernel.
Aslo we never saw the IPv6: fakelowpan: IPv6 duplicate address fe80::203:9a00:2:12c detected! message in the old build.

Starting 802.15.4 loopback:
[   25.215772] ieee802154fakelb ieee802154fakelb: added ieee802154 hardware
iwpan phy phy2 interface add wpan2 type node 00:03:9a:00:00:02:01:2c
ip link add link wpan2 name fakelowpan type lowpan
ifconfig fakelowpan up
ifconfig wpan2 up
[   26.839092] IPv6: fakelowpan: IPv6 duplicate address fe80::203:9a00:2:12c detected!
[   27.109497] Unable to handle kernel NULL pointer dereference at virtual address 00000004
[   27.117623] pgd = c0004000
[   27.120369] [00000004] *pgd=00000000
[   27.123937] Internal error: Oops: 17 [#1] PREEMPT SMP ARM
[   27.129300] Modules linked in: fakelb mrf24j40 adc7923(O) hanadu(O) ansi_cprng
[   27.136547] CPU: 0 PID: 19 Comm: kworker/u4:1 Tainted: G           O    4.0.0-rc7-brian #2
[   27.144783] Hardware name: Xilinx Zynq Platform
[   27.149337] task: df49c500 ti: df4c0000 task.ti: df4c0000
[   27.154766] PC is at process_one_work+0x24/0x330
[   27.159373] LR is at worker_thread+0x4c/0x474
[   27.163722] pc : [<c0035810>]    lr : [<c0036214>]    psr: 40000093
[   27.163722] sp : df4c1f08  ip : 00000000  fp : df42b400
[   27.175185] r10: df470900  r9 : c071c223  r8 : 00000088
[   27.180396] r7 : 00000000  r6 : df42b400  r5 : c0755818  r4 : df470900
[   27.186905] r3 : 00000004  r2 : 00000080  r1 : c0755818  r0 : df470900
[   27.193426] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[   27.200797] Control: 18c5387d  Table: 1ef3c04a  DAC: 00000015
[   27.206527] Process kworker/u4:1 (pid: 19, stack limit = 0xdf4c0210)
[   27.212859] Stack: (0xdf4c1f08 to 0xdf4c2000)
[   27.217226] 1f00:                   df4c0000 df42b400 00000001 df42b400 df470918 df42b414
[   27.218183] mrf24j40 spi32765.0: SPI transfer timed out
[   27.218296] mrf24j40 spi32765.0: SPI write Failed for TX buf
[   27.236260] 1f20: df4c0000 00000088 c071c223 df470900 df42b400 c0036214 c06ec100 df4364c0
[   27.244438] 1f40: df470900 00000000 df4364c0 df470900 c00361c8 00000000 00000000 00000000
[   27.252614] 1f60: 00000000 c003a2a0 a968274f 00000000 7deedc4b df470900 00000000 00000000
[   27.260791] 1f80: df4c1f80 df4c1f80 00000000 00000000 df4c1f90 df4c1f90 df4c1fac df4364c0
[   27.268964] 1fa0: c003a1c4 00000000 00000000 c000e700 00000000 00000000 00000000 00000000
[   27.277138] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   27.285312] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 f3ad6f7f 14fb7779
[   27.293548] [<c0035810>] (process_one_work) from [<c0036214>] (worker_thread+0x4c/0x474)
[   27.301664] [<c0036214>] (worker_thread) from [<c003a2a0>] (kthread+0xdc/0xf4)
[   27.308927] [<c003a2a0>] (kthread) from [<c000e700>] (ret_from_fork+0x14/0x34)
[   27.316158] Code: e1a04000 e2137004 13c370ff e5963010 (e5972004)
[   27.322235] ---[ end trace b28566c42ca64525 ]---
[   27.326835] note: kworker/u4:1[19] exited with preempt_count 1
[   27.333401] Unable to handle kernel paging request at virtual address ffffffec
[   27.340604] pgd = c0004000
[   27.343293] [ffffffec] *pgd=1fffd821, *pte=00000000, *ppte=00000000
[   27.349558] Internal error: Oops: 17 [#2] PREEMPT SMP ARM
[   27.354916] Modules linked in: fakelb mrf24j40 adc7923(O) hanadu(O) ansi_cprng
[   27.362163] CPU: 0 PID: 19 Comm: kworker/u4:1 Tainted: G      D    O    4.0.0-rc7-brian #2
[   27.370391] Hardware name: Xilinx Zynq Platform
[   27.374955] task: df49c500 ti: df4c0000 task.ti: df4c0000
[   27.380350] PC is at kthread_data+0x4/0xc
[   27.384358] LR is at wq_worker_sleeping+0xc/0xd0
[   27.388964] pc : [<c003a7e0>]    lr : [<c00366cc>]    psr: 20000193
[   27.388964] sp : df4c1cc8  ip : 00000001  fp : df4c1d04
[   27.400429] r10: c0035812  r9 : 00000000  r8 : df49c7bc
[   27.405641] r7 : c06ede98  r6 : df49c500  r5 : c06e78c0  r4 : 00000000
[   27.412148] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : df49c500
[   27.418668] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
[   27.425867] Control: 18c5387d  Table: 1ef3c04a  DAC: 00000015
[   27.431597] Process kworker/u4:1 (pid: 19, stack limit = 0xdf4c0210)
[   27.437929] Stack: (0xdf4c1cc8 to 0xdf4c2000)
[   27.442299] 1cc0:                   00000020 dfbd78c0 c06e78c0 c04d70d4 00000000 c0022df4
[   27.450478] 1ce0: dec330cc c06eb23c df4c0000 df4c1acc 00000001 df4c1d20 df49c738 00000001
[   27.458657] 1d00: df4c1d14 c04d72f8 0420806c df49c500 df42c9c0 c00234c8 c05e0d90 df4c1d3c
[   27.466837] 1d20: df4c1d20 df4c1d20 c06f2d9c c071c6c4 c06f2d9c 60000193 0000000b c0035814
[   27.475012] 1d40: 00000001 c0035812 c05da660 c0011b1c df4c0210 0000000b c06f2d9c 00000000
[   27.483190] 1d60: 00000000 00000008 65000000 34306131 20303030 33313265 34303037 63333120
[   27.491367] 1d80: 66303733 35652066 30333639 28203031 37393565 34303032 c0002029 df4c1dbc
[   27.499542] 1da0: df42b400 00000004 00000017 df4c1ec0 00000000 df49c500 00000004 df470900
[   27.507720] 1dc0: df42b400 c04d4410 00000017 c001a45c 00000001 00000001 df4c1dec c0041ac0
[   27.515897] 1de0: c06ec0c0 c06f5030 000003df c04da5a8 80000051 c0038904 00000000 c06f312c
[   27.524072] 1e00: 00000017 c001a284 00000004 df4c1ec0 c071c223 df470900 df42b400 c0008510
[   27.532250] 1e20: 00017cc8 00000000 00000000 c06e78c0 df49c500 c06ede98 c06ed50c c06e78c0
[   27.540425] 1e40: 00000000 c0047448 00000000 dfbd78c0 ff8a8acb ffffffff df49c548 c06ede98
[   27.548604] 1e60: df4c1e7c df49c500 dfbd78c0 dfbd78c0 c06e78c0 df49c500 c06ede98 dfbd78c0
[   27.556779] 1e80: 00000001 dfbd7900 c06e78c0 c004b7c8 00000000 dfbd78c0 dfbd78c0 df49c500
[   27.564958] 1ea0: 0000062f 0000b7f8 c0035810 40000093 ffffffff df4c1ef4 00000088 c0012398
[   27.573131] 1ec0: df470900 c0755818 00000080 00000004 df470900 c0755818 df42b400 00000000
[   27.581309] 1ee0: 00000088 c071c223 df470900 df42b400 00000000 df4c1f08 c0036214 c0035810
[   27.589486] 1f00: 40000093 ffffffff df4c0000 df42b400 00000001 df42b400 df470918 df42b414
[   27.597662] 1f20: df4c0000 00000088 c071c223 df470900 df42b400 c0036214 c06ec100 df4364c0
[   27.605836] 1f40: df470900 00000000 df4364c0 df470900 c00361c8 00000000 00000000 00000000
[   27.614012] 1f60: 00000000 c003a2a0 a968274f 00000000 7deedc4b df470900 00000000 00000000
[   27.622192] 1f80: df4c1f80 df4c1f80 00000001 00010001 df4c1f90 df4c1f90 df4c1fac df4364c0
[   27.630364] 1fa0: c003a1c4 00000000 00000000 c000e700 00000000 00000000 00000000 00000000
[   27.638537] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   27.646708] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 f3ad6f7f 14fb7779
[   27.654934] [<c003a7e0>] (kthread_data) from [<c00366cc>] (wq_worker_sleeping+0xc/0xd0)
[   27.662992] [<c00366cc>] (wq_worker_sleeping) from [<c04d70d4>] (__schedule+0x354/0x538)
[   27.671105] [<c04d70d4>] (__schedule) from [<c04d72f8>] (schedule+0x40/0x98)
[   27.678167] [<c04d72f8>] (schedule) from [<c00234c8>] (do_exit+0x610/0x940)
[   27.685167] [<c00234c8>] (do_exit) from [<c0011b1c>] (die+0x228/0x40c)
[   27.691720] [<c0011b1c>] (die) from [<c04d4410>] (__do_kernel_fault.part.10+0x64/0x74)
[   27.699697] [<c04d4410>] (__do_kernel_fault.part.10) from [<c001a45c>] (do_page_fault+0x1d8/0x368)
[   27.708681] [<c001a45c>] (do_page_fault) from [<c0008510>] (do_DataAbort+0x38/0xb4)
[   27.716356] [<c0008510>] (do_DataAbort) from [<c0012398>] (__dabt_svc+0x38/0x60)
[   27.723726] Exception stack(0xdf4c1ec0 to 0xdf4c1f08)
[   27.728795] 1ec0: df470900 c0755818 00000080 00000004 df470900 c0755818 df42b400 00000000
[   27.736977] 1ee0: 00000088 c071c223 df470900 df42b400 00000000 df4c1f08 c0036214 c0035810
[   27.745125] 1f00: 40000093 ffffffff
[   27.748664] [<c0012398>] (__dabt_svc) from [<c0035810>] (process_one_work+0x24/0x330)
[   27.756523] [<c0035810>] (process_one_work) from [<c0036214>] (worker_thread+0x4c/0x474)
[   27.764628] [<c0036214>] (worker_thread) from [<c003a2a0>] (kthread+0xdc/0xf4)
[   27.771870] [<c003a2a0>] (kthread) from [<c000e700>] (ret_from_fork+0x14/0x34)
[   27.779094] Code: e513001c e7e00150 e12fff1e e5903290 (e5130014)
[   27.785173] ---[ end trace b28566c42ca64526 ]---
[   27.789754] Fixing recursive fault but reboot is needed!

Here are the commands I use to setup each interface

*Powerline Interface*
iwpan phy phy0 interface add wpan0 type node 00:03:9a:00:00:00:01:2c
iwpan dev wpan0 set pan_id 0x0777
iwpan dev wpan0 set short_addr 0x012c
iwpan phy phy0 set channel 0 11
ip link add link wpan0 name lowpan0 type lowpan
ifconfig lowpan0 up
ifconfig wpan0 up

*Wireless Interface*
iwpan phy phy1 interface add wpan1 type node 00:03:9a:00:00:01:01:2c
iwpan dev wpan1 set pan_id 0x0700
iwpan dev wpan1 set short_addr 0x012c
iwpan phy phy1 set channel 0 20
ip link add link wpan1 name lowpan1 type lowpan
ifconfig lowpan1 up
ifconfig wpan1 up

*Fakelb Interface*
Starting 802.15.4 loopback:
iwpan phy phy2 interface add wpan2 type node 00:03:9a:00:00:02:01:2c
ip link add link wpan2 name fakelowpan type lowpan
ifconfig fakelowpan up
ifconfig wpan2 up

Also noticed that the extended address reported by iwpan doesn't look right
root@node-300:~# iwpan dev
phy#2
        Interface wpan2
                ifindex 12
                wpan_dev 0x200000002
                extended_addr 0x1013749720940844
                short_addr 0xffff
                pan_id 0xffff
                type node
                max_frame_retries 4
                min_be 4
                max_be 9
                max_csma_backoffs 8
                lbt 0
phy#1
        Interface wpan1
                ifindex 9
                wpan_dev 0x100000002
                extended_addr 0x1013749720875308
                short_addr 0x012c
                pan_id 0x0700
                type node
                max_frame_retries 4
                min_be 4
                max_be 9
                max_csma_backoffs 8
                lbt 0
phy#0
        Interface wpan0
                ifindex 6
                wpan_dev 0x2
                extended_addr 0x1013749720809772
                short_addr 0x012c
                pan_id 0x0777
                type node
                max_frame_retries 4
                min_be 4
                max_be 9
                max_csma_backoffs 8
                lbt 0


Any help appreciated!!

- Martin.

-- 
Xsilon Ltd.
Tel +44 (0)1793 843109
www.xsilon.com
Bowman House, Whitehill Lane,
Royal Wooton Bassett,
Swindon. SN4 7DB.

