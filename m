Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:9057 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755496AbaLILkF (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Tue, 9 Dec 2014 06:40:05 -0500
Message-ID: <1418125202.32209.51.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCHv3 bluetooth-next 3/3] 6lowpan: nhc: add other known
 rfc6282 compressions
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Tue, 09 Dec 2014 13:40:02 +0200
In-Reply-To: <1418124496.32209.47.camel@jrissane-mobl.ger.corp.intel.com>
References: <1418053838-8692-1-git-send-email-alex.aring@gmail.com>
	 <1418053838-8692-4-git-send-email-alex.aring@gmail.com>
	 <1418124496.32209.47.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <mtownsend1973@gmail.com>

On ti, 2014-12-09 at 13:28 +0200, Jukka Rissanen wrote:
> Hi Alex,
> 
> the module unloading caused some issues in the receiving end.

After more debugging, it was not necessary to unload the module. Just
removing the module file so that it is not loaded at all caused this
crash when UDP data was received.

Unloading the UDP nhc module in both peers works as expected. It is just
this unbalanced case that does not work.

> 
> I tried this:
> * setup bluetooth 6lowpan connection
> * transfer some UDP data
> * unload the nhc_rfc6282_udp module (in one peer only, the other still
> had udp nhc module loaded)
> * try to send more data
> 
> This caused kernel crash in peer that had udp module unloaded:
> 
> 
> [  154.430480] (NULL net_device): received unknown nhc id which was not
> found.
> [  154.846307] kmemleak: Cannot insert 0xcc4e2c00 into the object search
> tree (overlaps existing)
> [  154.847036] CPU: 0 PID: 291 Comm: systemd-journal Not tainted
> 3.17.0-bt6lowpan #2
> [  154.847036] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  154.847036]  cc4e2c00 00000000 ce06fd34 c1898b02 cd096320 ce06fd68
> c11716ac c1afdb94
> [  154.847036]  cc4e2c00 00000286 cd09634c 0000000e 00000010 cd09638c
> 00000000 000000d0
> [  154.847036]  cf001c00 cf001c00 ce06fd9c c1895ac8 000000d0 ce06fd80
> c10729cb 00000001
> [  154.847036] Call Trace:
> [  154.847036]  [<c1898b02>] dump_stack+0x4b/0x75
> [  154.847036]  [<c11716ac>] create_object+0x22c/0x280
> [  154.847036]  [<c1895ac8>] kmemleak_alloc+0x38/0xb0
> [  154.847036]  [<c10729cb>] ? get_parent_ip+0xb/0x40
> [  154.847036]  [<c1072a4b>] ? preempt_count_add+0x4b/0xa0
> [  154.847036]  [<c1165123>] kmem_cache_alloc_trace+0x1c3/0x2a0
> [  154.847036]  [<c1196674>] ? seq_open+0xa4/0xc0
> [  154.847036]  [<c1196674>] seq_open+0xa4/0xc0
> [  154.847036]  [<c11c7750>] ? proc_setattr+0x50/0x50
> [  154.847036]  [<c1196f1f>] single_open+0x4f/0x90
> [  154.847036]  [<c11c8749>] proc_single_open+0x19/0x20
> [  154.847036]  [<c1172ecc>] do_dentry_open+0x19c/0x2d0
> [  154.847036]  [<c11c8730>] ? sched_open+0x20/0x20
> [  154.847036]  [<c117354b>] finish_open+0x2b/0x50
> [  154.847036]  [<c118249a>] do_last.isra.40+0x5fa/0xcc0
> [  154.847036]  [<c117fa1e>] ? link_path_walk+0x5e/0x790
> [  154.847036]  [<c1182c06>] path_openat+0xa6/0x5c0
> [  154.847036]  [<c13e0112>] ? debug_smp_processor_id+0x12/0x20
> [  154.847036]  [<c11842b1>] do_filp_open+0x31/0x90
> [  154.847036]  [<c1174727>] do_sys_open+0x117/0x210
> [  154.847036]  [<c18a192f>] ? restore_all+0xf/0xf
> [  154.847036]  [<c13e012f>] ? __this_cpu_preempt_check+0xf/0x20
> [  154.847036]  [<c1080000>] ? pick_next_task_fair+0x340/0x550
> [  154.847036]  [<c1174842>] SyS_open+0x22/0x30
> [  154.847036]  [<c18a18f6>] syscall_call+0x7/0x7
> [  154.847036]  [<c18a0000>] ? __account_scheduler_latency+0x60/0x2a0
> [  154.847036] kmemleak: Kernel memory leak detector disabled
> [  154.847036] kmemleak: Object 0xcc4e2c00 (size 192):
> [  154.847036] kmemleak:   comm "systemd-journal", pid 291, jiffies
> 4294822142
> [  154.847036] kmemleak:   min_count = 1
> [  154.847036] kmemleak:   count = 0
> [  154.847036] kmemleak:   flags = 0x1
> [  154.847036] kmemleak:   checksum = 0
> [  154.847036] kmemleak:   backtrace:
> [  154.847036]      [<c1895ac8>] kmemleak_alloc+0x38/0xb0
> [  154.847036]      [<c1164e83>] kmem_cache_alloc+0x1c3/0x2a0
> [  154.847036]      [<c177a5d1>] __alloc_skb+0x41/0x1b0
> [  154.847036]      [<c177a84b>] alloc_skb_with_frags+0x4b/0x1c0
> [  154.847036]      [<c177394a>] sock_alloc_send_pskb+0x1aa/0x210
> [  154.847036]      [<c1826d28>] unix_dgram_sendmsg+0x138/0x560
> [  154.847036]      [<c17702b9>] sock_sendmsg+0x59/0x80
> [  154.847036]      [<c177179f>] ___sys_sendmsg.part.30+0x2df/0x2f0
> [  154.847036]      [<c1772724>] __sys_sendmsg+0x44/0x80
> [  154.847036]      [<c1772d80>] SyS_socketcall+0xd0/0x2b0
> [  154.847036]      [<c18a18f6>] syscall_after_call+0x0/0x4
> [  154.847036]      [<ffffffff>] 0xffffffff
> [  172.825327] Clocksource tsc unstable (delta = 14060914275 ns)
> [  173.175027] INFO: trying to register non-static key.
> [  173.175694] the code is fine but needs lockdep annotation.
> [  173.175694] turning off the locking correctness validator.
> [  173.175694] CPU: 0 PID: 378 Comm: syslogd Not tainted
> 3.17.0-bt6lowpan #2
> [  173.175694] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  173.175694]  00000000 00000000 cd669cf4 c1898b02 c22f0890 cd669d70
> c109412a c1ae4b78
> [  173.175694]  cf794500 c1ead500 00000000 cd669d44 c107770f 00000000
> 007b23e7 00000000
> [  173.175694]  c1ead500 00004a25 00004a25 c1d67cc0 00000000 cc4e58e8
> c13e0112 cd669d4c
> [  173.175694] Call Trace:
> [  173.175694]  [<c1898b02>] dump_stack+0x4b/0x75
> [  173.175694]  [<c109412a>] __lock_acquire+0x189a/0x1d20
> [  173.175694]  [<c107770f>] ? sched_clock_cpu+0x10f/0x160
> [  173.175694]  [<c13e0112>] ? debug_smp_processor_id+0x12/0x20
> [  173.175694]  [<c108e584>] ? get_lock_stats+0x24/0x40
> [  173.175694]  [<c189fa95>] ? schedule_timeout+0x145/0x200
> [  173.175694]  [<c1090a34>] ? mark_held_locks+0x64/0x90
> [  173.175694]  [<c1094c56>] lock_acquire+0xb6/0x170
> [  173.175694]  [<c177e385>] ? __skb_recv_datagram+0x65/0x480
> [  173.175694]  [<c18a0899>] _raw_spin_lock_irqsave+0x59/0x90
> [  173.175694]  [<c177e385>] ? __skb_recv_datagram+0x65/0x480
> [  173.175694]  [<c177e385>] __skb_recv_datagram+0x65/0x480
> [  173.175694]  [<c1090cab>] ? trace_hardirqs_on+0xb/0x10
> [  173.175694]  [<c177e7e0>] ? skb_recv_datagram+0x40/0x40
> [  173.175694]  [<c182747f>] unix_dgram_recvmsg+0x7f/0x3e0
> [  173.175694]  [<c1770f06>] sock_aio_read+0xc6/0x100
> [  173.175694]  [<c10bde45>] ? clockevents_program_event+0xa5/0x150
> [  173.175694]  [<c1174ce7>] do_sync_read+0x57/0x90
> [  173.175694]  [<c1175878>] vfs_read+0x108/0x140
> [  173.175694]  [<c1175e22>] SyS_read+0x52/0xb0
> [  173.175694]  [<c18a18f6>] syscall_call+0x7/0x7
> [  173.175694] BUG: unable to handle kernel NULL pointer dereference at
> 0000006a
> [  173.175694] IP: [<c177e397>] __skb_recv_datagram+0x77/0x480
> [  173.175694] *pde = 00000000 
> [  173.175694] Oops: 0000 [#1] PREEMPT SMP 
> [  173.175694] Modules linked in: nhc_rfc6282_route nhc_rfc6282_dest
> bluetooth_6lowpan nhc_rfc6282_mobil nhc_rfc6282_frag nhc_rfc6282_hop
> nhc_rfc6282_ipv6 6lowpan ecb btusb bluetooth nfc rfkill snd_intel8x0
> snd_ac97_codec ohci_pci ac97_bus parport_pc parport uvesafb [last
> unloaded: nhc_rfc6282_udp]
> 

Cheers,
Jukka


