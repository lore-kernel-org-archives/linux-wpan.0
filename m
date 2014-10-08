Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50653 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbaJHLHg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 07:07:36 -0400
Message-ID: <54351AF4.5060907@xsilon.com>
Date: Wed, 08 Oct 2014 12:07:32 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>	 <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>	 <543408B2.1070309@xsilon.com> <1412763863.2705.22.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1412763863.2705.22.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Jukka,

And there's no oops when kmemleak is activated on a kernel without the patch?

- Martin.


On 08/10/14 11:24, Jukka Rissanen wrote:
> Hi Martin,
>
> tried to v2 of the patch and still see oops but not with the locking at
> this time. I had kmemleak activated in my kernel in this run.
>
> On ti, 2014-10-07 at 16:37 +0100, Martin Townsend wrote:
>> I should also mention this has only been compile tested as I currently don't have a way of testing it easily.  So I would appreciate any testing on real HW.
>>
>>  Jukka, I would be very interested to see if you see that locking error message you were seeing previously.
>>
>> - Martin.
>>
>
> [  243.774232] kmemleak: Cannot insert 0xf45bde40 into the object search
> tree (overlaps existing)
> [  243.775060] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 3.17.0-rc1-bt6lowpan #1
> [  243.775060] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  243.775060]  f45bde40 00000000 f600bb74 c18821c1 e716a0c8 f600bba8
> c116abac c1ae324c
> [  243.775060]  f45bde40 00200282 e716a0f4 00000010 00000010 e716a134
> 00000000 f45bde40
> [  243.775060]  f6001c00 f6001c00 f600bbd4 c187f10c 00000020 f600bbd4
> 00200246 f47805c0
> [  243.775060] Call Trace:
> [  243.775060]  [<c18821c1>] dump_stack+0x4b/0x75
> [  243.775060]  [<c116abac>] create_object+0x22c/0x280
> [  243.775060]  [<c187f10c>] kmemleak_alloc+0x3c/0xb0
> [  243.775060]  [<c115e693>] kmem_cache_alloc+0x1a3/0x290
> [  243.775060]  [<c1761ea0>] ? skb_clone+0x40/0xa0
> [  243.775060]  [<c1761ea0>] skb_clone+0x40/0xa0
> [  243.775060]  [<c179a15b>] netlink_broadcast_filtered+0x25b/0x310
> [  243.775060]  [<c179a23e>] netlink_broadcast+0x2e/0x40
> [  243.775060]  [<c179c68e>] nlmsg_notify+0xbe/0xd0
> [  243.775060]  [<c178064f>] rtnl_notify+0x3f/0x60
> [  243.775060]  [<c1828382>] inet6_rt_notify+0xe2/0x150
> [  243.775060]  [<c182a228>] fib6_add+0x388/0x7c0
> [  243.775060]  [<c1825533>] ip6_ins_rt+0x53/0x70
> [  243.775060]  [<c1825828>] ip6_pol_route.isra.42+0x2d8/0x3e0
> [  243.775060]  [<c1825963>] ip6_pol_route_input+0x33/0x40
> [  243.775060]  [<c1825930>] ? ip6_pol_route.isra.42+0x3e0/0x3e0
> [  243.775060]  [<c184aba9>] fib6_rule_action+0x79/0x1a0
> [  243.775060]  [<c178d0a7>] fib_rules_lookup+0x117/0x1a0
> [  243.775060]  [<c178cf90>] ? fib_rules_net_init+0x30/0x30
> [  243.775060]  [<c184aedb>] fib6_rule_lookup+0x3b/0x70
> [  243.775060]  [<c1825930>] ? ip6_pol_route.isra.42+0x3e0/0x3e0
> [  243.775060]  [<c1825106>] ip6_route_input_lookup.isra.39+0x46/0x50
> [  243.775060]  [<c1825930>] ? ip6_pol_route.isra.42+0x3e0/0x3e0
> [  243.775060]  [<c1825a4d>] ip6_route_input+0x9d/0xb0
> [  243.775060]  [<c18187f7>] ip6_rcv_finish+0x147/0x1d0
> [  243.775060]  [<c18197c6>] ipv6_rcv+0x686/0xa10
> [  243.775060]  [<c17716cb>] ? __netif_receive_skb_core+0x4ab/0x7b0
> [  243.775060]  [<c17716cb>] __netif_receive_skb_core+0x4ab/0x7b0
> [  243.775060]  [<c1771279>] ? __netif_receive_skb_core+0x59/0x7b0
> [  243.775060]  [<c17719eb>] __netif_receive_skb+0x1b/0x70
> [  243.775060]  [<c177300f>] process_backlog+0x9f/0x140
> [  243.775060]  [<c1772e48>] net_rx_action+0x128/0x250
> [  243.775060]  [<c104fd84>] __do_softirq+0xd4/0x300
> [  243.775060]  [<c104fcb0>] ? __local_bh_enable_ip+0xf0/0xf0
> [  243.775060]  [<c10049fc>] do_softirq_own_stack+0x2c/0x40
> [  243.775060]  <IRQ>  [<c1050136>] irq_exit+0x86/0xb0
> [  243.775060]  [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
> [  243.775060]  [<c188b6ce>] apic_timer_interrupt+0x32/0x38
> [  243.775060]  [<c107007b>] ? resched_cpu+0x7b/0x80
> [  243.775060]  [<c10be4ea>] ? tick_nohz_idle_enter+0x4a/0x80
> [  243.775060]  [<c10848d5>] cpu_startup_entry+0x35/0x370
> [  243.775060]  [<c10718bb>] ? preempt_count_add+0x4b/0xa0
> [  243.775060]  [<c187dbd1>] rest_init+0xa1/0xb0
> [  243.775060]  [<c1c93aa1>] start_kernel+0x386/0x38b
> [  243.775060]  [<c1c932ab>] i386_start_kernel+0x79/0x7d
> [  243.775060] kmemleak: Kernel memory leak detector disabled
> [  243.775060] kmemleak: Object 0xf45bde40 (size 192):
> [  243.775060] kmemleak:   comm "softirq", pid 0, jiffies 4294911070
> [  243.775060] kmemleak:   min_count = 1
> [  243.775060] kmemleak:   count = 0
> [  243.775060] kmemleak:   flags = 0x1
> [  243.775060] kmemleak:   checksum = 0
> [  243.775060] kmemleak:   backtrace:
> [  243.775060]      [<c187f10c>] kmemleak_alloc+0x3c/0xb0
> [  243.775060]      [<c115e693>] kmem_cache_alloc+0x1a3/0x290
> [  243.775060]      [<c17635e1>] __alloc_skb+0x41/0x1c0
> [  243.775060]      [<c18282f5>] inet6_rt_notify+0x55/0x150
> [  243.775060]      [<c182a228>] fib6_add+0x388/0x7c0
> [  243.775060]      [<c1825533>] ip6_ins_rt+0x53/0x70
> [  243.775060]      [<c1825828>] ip6_pol_route.isra.42+0x2d8/0x3e0
> [  243.775060]      [<c1825963>] ip6_pol_route_input+0x33/0x40
> [  243.775060]      [<c184aba9>] fib6_rule_action+0x79/0x1a0
> [  243.775060]      [<c178d0a7>] fib_rules_lookup+0x117/0x1a0
> [  243.775060]      [<c184aedb>] fib6_rule_lookup+0x3b/0x70
> [  243.775060]      [<c1825106>] ip6_route_input_lookup.isra.39
> +0x46/0x50
> [  243.775060]      [<c1825a4d>] ip6_route_input+0x9d/0xb0
> [  243.775060]      [<c18187f7>] ip6_rcv_finish+0x147/0x1d0
> [  243.775060]      [<c18197c6>] ipv6_rcv+0x686/0xa10
> [  243.775060]      [<c17716cb>] __netif_receive_skb_core+0x4ab/0x7b0
> [  244.044145] BUG: unable to handle kernel NULL pointer dereference at
> 0000006c
> [  244.044227] IP: [<c115ffc0>] __kmalloc_track_caller+0xb0/0x2b0
> [  244.044227] *pde = 00000000 
> [  244.044227] Oops: 0000 [#1] PREEMPT SMP 
> [  244.044227] Modules linked in: bluetooth_6lowpan 6lowpan rfcomm bnep
> ecb btusb bluetooth nfc rfkill snd_intel8x0 parport_pc ohci_pci
> snd_ac97_codec ac97_bus parport
>
>
>
> Cheers,
> Jukka
>
>

