Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35163 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbbERPhW (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 11:37:22 -0400
Received: by wicmx19 with SMTP id mx19so84376229wic.0
        for <linux-wpan@vger.kernel.org>; Mon, 18 May 2015 08:37:19 -0700 (PDT)
Date: Mon, 18 May 2015 17:37:16 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Kernel crash when using multiple interfaces
Message-ID: <20150518153712.GC749@omega>
References: <5555EC72.6060302@xsilon.com>
 <20150515142026.GA11157@omega>
 <55560A88.1050903@xsilon.com>
 <20150516153329.GA31491@omega>
 <5559C58F.6010607@xsilon.com>
 <20150518140045.GA749@omega>
 <5559FFC2.9000309@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5559FFC2.9000309@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Mon, May 18, 2015 at 04:05:38PM +0100, Simon Vincent wrote:
> With your patch I get either a "bad paging request" or a NULL pointer
> dereference crash at startup. I have not had any problems with my patch.
> 
> Here are two stack traces I get.
> 
> [   12.223057] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>]
> 
> or
> 
> [   12.548824] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>]

Both crashes in ieee802154_stop_queue, but we don't changed anything
which should affect the ieee802154_stop_queue in my or your fix.

I don't know what happens here, why it crashes now in
ieee802154_stop_queue.

I can reproduce the issue (with no patches applied and two lowpan
interface with the reworked fakelb driver). I get now:

BUG: unable to handle kernel NULL pointer dereference at 00000004
IP: [<c013ae6a>] process_one_work+0x29/0x2a5
*pde = 00000000 
Oops: 0000 [#1] SMP 
Modules linked in:
CPU: 0 PID: 436 Comm: kworker/u2:4 Not tainted 4.1.0-rc3-00545-gd0f8937 #1078
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
task: f73cf4d0 ti: f7184000 task.ti: f7184000
EIP: 0060:[<c013ae6a>] EFLAGS: 00010046 CPU: 0
EIP is at process_one_work+0x29/0x2a5
EAX: 00000000 EBX: f724bac0 ECX: 00000004 EDX: c0e74aec
ESI: f701d400 EDI: f7185ef0 EBP: f7185f0c ESP: f7185edc
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
CR0: 8005003b CR2: 000000a4 CR3: 3699b000 CR4: 00000690
Stack:
 f734f800 00000000 00000000 c0e74aec f701d400 c0e74ae0 c0b284c0 00000000
 c05e743a f724bac0 f701d400 f724bad8 f7185f30 c013b4de f73cf4d0 f701d430
 f724bac0 c013b330 f72d0100 f724bac0 c013b330 f7185fac c013e8fa f7185f74
Call Trace:
 [<c013b4de>] worker_thread+0x1ae/0x241
 [<c013b330>] ? rescuer_thread+0x229/0x229
 [<c013b330>] ? rescuer_thread+0x229/0x229
 [<c013e8fa>] kthread+0x8f/0x94
 [<c0140000>] ? SYSC_reboot+0x141/0x141
 [<c0487401>] ret_from_kernel_thread+0x21/0x30
 [<c013e86b>] ? __kthread_parkme+0x54/0x54
Code: 5d c3 55 89 e5 57 56 53 89 c3 89 d0 8d 7d e4 83 ec 24 89 55 dc e8 3a dd ff ff 89 45 d8 8b 43 24 b9 04 00 00 00 89 45 e0 8b 45 d8 <8b> 40 04 8b 80 00 01 00 00 c1 e8 05 83 e0 01 88 45 d7 8b 45 dc
EIP: [<c013ae6a>] process_one_work+0x29/0x2a5 SS:ESP 0068:f7185edc
CR2: 0000000000000004
---[ end trace f75bf0513b11ceb0 ]---
BUG: unable to handle kernel paging request at ffffffd0
IP: [<c013ea2f>] kthread_data+0x9/0xe
*pde = 006c7067 *pte = 00000000 
Oops: 0000 [#2] SMP 
Modules linked in:
CPU: 0 PID: 436 Comm: kworker/u2:4 Tainted: G      D         4.1.0-rc3-00545-gd0f8937 #1078
Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
task: f73cf4d0 ti: f7184000 task.ti: f7184000
EIP: 0060:[<c013ea2f>] EFLAGS: 00010002 CPU: 0
EIP is at kthread_data+0x9/0xe
EAX: 00000000 EBX: f7800340 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: f73cf758 EBP: f7185d74 ESP: f7185d74
 DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
CR0: 8005003b CR2: 00000014 CR3: 3699b000 CR4: 00000690
Stack:
 f7185d84 c013b5cc f7800340 00000000 f7185da4 c0483b71 00000000 00000000
 f73cf4d0 f7186000 f7185bb4 f7185dd4 f7185db0 c0483f7e f73cf4d0 f7185de8
 c012c9cd f73cf8d0 00000001 f73cf6d4 f70413b0 f7185ea0 f7185de0 f6a839ec
Call Trace:
 [<c013b5cc>] wq_worker_sleeping+0xc/0x76
 [<c0483b71>] __schedule+0x178/0x528
 [<c0483f7e>] schedule+0x5d/0x6a
 [<c012c9cd>] do_exit+0x749/0x75f
 [<c0103e84>] oops_end+0x7b/0x82
 [<c0125637>] no_context+0x1b4/0x1be
 [<c0152a6f>] ? mark_lock+0x1e/0x1c4
 [<c0125767>] __bad_area_nosemaphore+0x126/0x130
 [<c04860c7>] ? __mutex_unlock_slowpath+0x10f/0x119
 [<c0125dc4>] ? vmalloc_sync_all+0x9c/0x9c
 [<c012577e>] bad_area_nosemaphore+0xd/0x10
 [<c0125b4e>] __do_page_fault+0x124/0x2fe
 [<c0151477>] ? trace_hardirqs_off_caller+0x39/0xa1
 [<c0125dc4>] ? vmalloc_sync_all+0x9c/0x9c
 [<c0125dcf>] do_page_fault+0xb/0xd
 [<c04881bf>] error_code+0x5f/0x70
 [<c013007b>] ? bin_intvec+0x6/0x163
 [<c0125dc4>] ? vmalloc_sync_all+0x9c/0x9c
 [<c013ae6a>] ? process_one_work+0x29/0x2a5
 [<c013b4de>] worker_thread+0x1ae/0x241
 [<c013b330>] ? rescuer_thread+0x229/0x229
 [<c013b330>] ? rescuer_thread+0x229/0x229
 [<c013e8fa>] kthread+0x8f/0x94
 [<c0140101>] ? async_synchronize_cookie_domain+0x4/0xa2
 [<c0487401>] ret_from_kernel_thread+0x21/0x30
 [<c013e86b>] ? __kthread_parkme+0x54/0x54
Code: 31 c0 59 5b 5e 5f 5d c3 55 64 a1 0c 67 6b c0 8b 80 5c 02 00 00 89 e5 5d 8b 40 c8 c1 e8 02 83 e0 01 c3 55 8b 80 5c 02 00 00 89 e5 <8b> 40 d0 5d c3 55 b9 04 00 00 00 89 e5 52 8b 90 5c 02 00 00 8d
EIP: [<c013ea2f>] kthread_data+0x9/0xe SS:ESP 0068:f7185d74
CR2: 00000000ffffffd0
---[ end trace f75bf0513b11ceb1 ]---


This is the issue which you should have now at mainline state. I created
a github branch so you can try it yourself [0]. I simple loaded the
fakelb driver and creating lowpan interfaces on each registered phy.

I also created a branch [1] which contains the suggested fix without
running kmalloc. In my case the above error doesn't occur anymore and I
don't have a "bad paging request".


I don't know now what's going on there that your fix works and mine not
on your side, I just want to be sure that I know whats going on there.
If we don't getting to know more, then just send your patch (based on
bluetooth, but should be the same like bluetooth-next). I will test it
then on my side and if it works, then everything is fine.

- Alex


[0] https://github.com/linux-wpan/linux-wpan-next/tree/for_simon_multiple_phy_fail
[1] https://github.com/linux-wpan/linux-wpan-next/tree/for_simon_multiple_phy_works
