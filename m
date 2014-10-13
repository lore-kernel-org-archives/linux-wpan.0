Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11176 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbaJMLtj (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 13 Oct 2014 07:49:39 -0400
Message-ID: <1413200959.2705.90.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v6 bluetooth-next] 6lowpan: Use skb_cow in IPHC
 decompression.
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 13 Oct 2014 14:49:19 +0300
In-Reply-To: <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
References: <1413194456-26351-1-git-send-email-martin.townsend@xsilon.com>
	 <1413194456-26351-2-git-send-email-martin.townsend@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

with this v6 I started to see similar issues locking issues as in some
earlier patch version. I will try v5 and v4 just to make sure what is
going on here.


[  308.736047] =================================
[  308.736047] [ INFO: inconsistent lock state ]
[  308.736047] 3.17.0-rc1-bt6lowpan #1 Not tainted
[  308.736047] ---------------------------------
[  308.736047] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  308.736047] kworker/u3:2/404 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  308.736047]  (&(&list->lock)->rlock#6){+.?...}, at: [<f82a8d4c>]
hci_send_acl+0xac/0x290 [bluetooth]
[  308.736047] {IN-SOFTIRQ-W} state was registered at:
[  308.736047]   [<c10915a3>] __lock_acquire+0x6d3/0x1d20
[  308.736047]   [<c109325d>] lock_acquire+0x9d/0x140
[  308.736047]   [<c1889c25>] _raw_spin_lock+0x45/0x80
[  308.736047]   [<f82a8d4c>] hci_send_acl+0xac/0x290 [bluetooth]
[  308.736047]   [<f82c9bf0>] l2cap_do_send+0x60/0x100 [bluetooth]
[  308.736047]   [<f82cd7c0>] l2cap_chan_send+0x7f0/0x10e0 [bluetooth]
[  308.736047]   [<f850d91e>] send_pkt+0x4e/0xa0 [bluetooth_6lowpan]
[  308.736047]   [<f850dd20>] bt_xmit+0x3b0/0x770 [bluetooth_6lowpan]
[  308.736047]   [<c17742f4>] dev_hard_start_xmit+0x344/0x670
[  308.736047]   [<c17749ad>] __dev_queue_xmit+0x38d/0x680
[  308.736047]   [<c1774caf>] dev_queue_xmit+0xf/0x20
[  308.736047]   [<c177b8b0>] neigh_connected_output+0x130/0x1a0
[  308.736047]   [<c1812a63>] ip6_finish_output2+0x173/0x8c0
[  308.736047]   [<c18182db>] ip6_finish_output+0x7b/0x1b0
[  308.736047]   [<c18184a7>] ip6_output+0x97/0x2a0
[  308.736047]   [<c183a46b>] mld_sendpack+0x5eb/0x650
[  308.736047]   [<c183acc1>] mld_ifc_timer_expire+0x191/0x2f0
[  308.736047]   [<c10ac385>] call_timer_fn+0x85/0x1c0
[  308.736047]   [<c10acb72>] run_timer_softirq+0x192/0x280
[  308.736047]   [<c104fd84>] __do_softirq+0xd4/0x300
[  308.736047]   [<c10049fc>] do_softirq_own_stack+0x2c/0x40
[  308.736047]   [<c1050136>] irq_exit+0x86/0xb0
[  308.736047]   [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
[  308.736047]   [<c188b6ce>] apic_timer_interrupt+0x32/0x38
[  308.736047]   [<c115e6b2>] kmem_cache_alloc+0x1c2/0x290
[  308.736047]   [<c116a9ae>] create_object+0x2e/0x280
[  308.736047]   [<c187f10c>] kmemleak_alloc+0x3c/0xb0
[  308.736047]   [<c115e693>] kmem_cache_alloc+0x1a3/0x290
[  308.736047]   [<c1178835>] getname_flags+0x25/0x110
[  308.736047]   [<c117d21e>] user_path_at_empty+0x1e/0x80
[  308.736047]   [<c1173317>] SyS_readlinkat+0x57/0x100
[  308.736047]   [<c11733ec>] SyS_readlink+0x2c/0x30
[  308.736047]   [<c188aeb6>] syscall_after_call+0x0/0x4
[  308.736047] irq event stamp: 37665
[  308.736047] hardirqs last  enabled at (37665): [<c188a065>]
_raw_spin_unlock_irqrestore+0x55/0x70
[  308.736047] hardirqs last disabled at (37664): [<c1889e03>]
_raw_spin_lock_irqsave+0x23/0x90
[  308.736047] softirqs last  enabled at (37378): [<c104ff5c>]
__do_softirq+0x2ac/0x300
[  308.736047] softirqs last disabled at (37359): [<c10049fc>]
do_softirq_own_stack+0x2c/0x40
[  308.736047] 
[  308.736047] other info that might help us debug this:
[  308.736047]  Possible unsafe locking scenario:
[  308.736047] 
[  308.736047]        CPU0
[  308.736047]        ----
[  308.736047]   lock(&(&list->lock)->rlock#6);
[  308.736047]   <Interrupt>
[  308.736047]     lock(&(&list->lock)->rlock#6);
[  308.736047] 
[  308.736047]  *** DEADLOCK ***
[  308.736047] 
[  308.736047] 3 locks held by kworker/u3:2/404:
[  308.736047]  #0:  ("%s"hdev->name#2){.+.+.+}, at: [<c10622c3>]
process_one_work+0x113/0x4a0
[  308.736047]  #1:  ((&hdev->rx_work)){+.+.+.}, at: [<c10622c3>]
process_one_work+0x113/0x4a0
[  308.736047]  #2:  (&chan->lock){+.+.+.}, at: [<f82c9179>]
l2cap_get_chan_by_dcid+0x89/0x90 [bluetooth]
[  308.736047] 
[  308.736047] stack backtrace:
[  308.736047] CPU: 0 PID: 404 Comm: kworker/u3:2 Not tainted
3.17.0-rc1-bt6lowpan #1
[  308.736047] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  308.736047] Workqueue: hci0 hci_rx_work [bluetooth]
[  308.736047]  efe3d780 00000000 efedbb90 c18821c1 c2345c10 efedbbb0
c1880a94 c1ad9264
[  308.736047]  c1ad9201 c1ad95f8 efe3dd94 00000006 c108e0c0 efedbbe0
c108ea8c 00000006
[  308.736047]  efe3d780 efedbffc e21128f4 00000047 00000004 efe3d780
efe3dd98 00000003
[  308.736047] Call Trace:
[  308.736047]  [<c18821c1>] dump_stack+0x4b/0x75
[  308.736047]  [<c1880a94>] print_usage_bug.part.36+0x209/0x213
[  308.736047]  [<c108e0c0>] ? check_usage_forwards+0x110/0x110
[  308.736047]  [<c108ea8c>] mark_lock+0x11c/0x6e0
[  308.736047]  [<c10915e4>] __lock_acquire+0x714/0x1d20
[  308.736047]  [<c1004b6f>] ? dump_trace+0xcf/0x1f0
[  308.736047]  [<c100a5f8>] ? sched_clock+0x8/0x10
[  308.736047]  [<c1075da9>] ? sched_clock_local+0x49/0x180
[  308.736047]  [<c109325d>] lock_acquire+0x9d/0x140
[  308.736047]  [<f82a8d4c>] ? hci_send_acl+0xac/0x290 [bluetooth]
[  308.736047]  [<c1889c25>] _raw_spin_lock+0x45/0x80
[  308.736047]  [<f82a8d4c>] ? hci_send_acl+0xac/0x290 [bluetooth]
[  308.736047]  [<f82a8d4c>] hci_send_acl+0xac/0x290 [bluetooth]
[  308.736047]  [<c108f0b4>] ? mark_held_locks+0x64/0x90
[  308.736047]  [<c188a065>] ? _raw_spin_unlock_irqrestore+0x55/0x70
[  308.736047]  [<f82c9bf0>] l2cap_do_send+0x60/0x100 [bluetooth]
[  308.736047]  [<c108f32b>] ? trace_hardirqs_on+0xb/0x10
[  308.736047]  [<c188a051>] ? _raw_spin_unlock_irqrestore+0x41/0x70
[  308.736047]  [<c1763125>] ? skb_dequeue+0x45/0x60
[  308.736047]  [<f82d4389>] l2cap_recv_frame+0x23d9/0x2db0 [bluetooth]
[  308.736047]  [<c1075da9>] ? sched_clock_local+0x49/0x180
[  308.736047]  [<c100a5f8>] ? sched_clock+0x8/0x10
[  308.736047]  [<c1075da9>] ? sched_clock_local+0x49/0x180
[  308.736047]  [<c10761ef>] ? sched_clock_cpu+0x10f/0x160
[  308.736047]  [<c107183b>] ? get_parent_ip+0xb/0x40
[  308.736047]  [<c10718bb>] ? preempt_count_add+0x4b/0xa0
[  308.736047]  [<c13d09e2>] ? debug_smp_processor_id+0x12/0x20
[  308.736047]  [<c108cc04>] ? get_lock_stats+0x24/0x40
[  308.736047]  [<c108f0b4>] ? mark_held_locks+0x64/0x90
[  308.736047]  [<c188716d>] ? __mutex_unlock_slowpath+0xcd/0x1b0
[  308.736047]  [<c13d09ff>] ? __this_cpu_preempt_check+0xf/0x20
[  308.736047]  [<c108f1d4>] ? trace_hardirqs_on_caller+0xf4/0x240
[  308.736047]  [<c108c9a6>] ? trace_hardirqs_off_caller+0xb6/0x160
[  308.736047]  [<f82d62a9>] l2cap_recv_acldata+0x2f9/0x340 [bluetooth]
[  308.736047]  [<f82a1a13>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
[  308.736047]  [<f82a1c69>] hci_rx_work+0x369/0x4a0 [bluetooth]
[  308.736047]  [<f82a1a13>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
[  308.736047]  [<c106234a>] process_one_work+0x19a/0x4a0
[  308.736047]  [<c10622c3>] ? process_one_work+0x113/0x4a0
[  308.736047]  [<c10629e9>] worker_thread+0x39/0x440
[  308.736047]  [<c10629b0>] ? init_pwq+0xc0/0xc0
[  308.736047]  [<c1066dc8>] kthread+0xa8/0xc0
[  308.736047]  [<c108f32b>] ? trace_hardirqs_on+0xb/0x10
[  308.736047]  [<c188ad01>] ret_from_kernel_thread+0x21/0x30
[  308.736047]  [<c1066d20>] ? kthread_create_on_node+0x160/0x160



Cheers,
Jukka


