Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50287 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbbERPFk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 18 May 2015 11:05:40 -0400
Message-ID: <5559FFC2.9000309@xsilon.com>
Date: Mon, 18 May 2015 16:05:38 +0100
From: Simon Vincent <simon.vincent@xsilon.com>
MIME-Version: 1.0
Subject: Re: Kernel crash when using multiple interfaces
References: <5555EC72.6060302@xsilon.com> <20150515142026.GA11157@omega> <55560A88.1050903@xsilon.com> <20150516153329.GA31491@omega> <5559C58F.6010607@xsilon.com> <20150518140045.GA749@omega>
In-Reply-To: <20150518140045.GA749@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

With your patch I get either a "bad paging request" or a NULL pointer 
dereference crash at startup. I have not had any problems with my patch.

Here are two stack traces I get.

[   12.223057] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>] 
(ieee802154_tx+0x6c/0x170)
[   12.231560] [<c04d6d64>] (ieee802154_tx) from [<c03d30e4>] 
(dev_hard_start_xmit+0x224/0x304)
[   12.239979] [<c03d30e4>] (dev_hard_start_xmit) from [<c03ec118>] 
(sch_direct_xmit+0xc4/0x1f4)
[   12.248474] [<c03ec118>] (sch_direct_xmit) from [<c03d3368>] 
(__dev_queue_xmit+0x1a4/0x4c4)
[   12.256803] [<c03d3368>] (__dev_queue_xmit) from [<c04d6484>] 
(lowpan_xmit+0x2a8/0x33c)
[   12.264787] [<c04d6484>] (lowpan_xmit) from [<c03d30e4>] 
(dev_hard_start_xmit+0x224/0x304)
[   12.273035] [<c03d30e4>] (dev_hard_start_xmit) from [<c03d35e8>] 
(__dev_queue_xmit+0x424/0x4c4)
[   12.281717] [<c03d35e8>] (__dev_queue_xmit) from [<c04684d8>] 
(ip6_finish_output2+0x1a0/0x5b4)
[   12.290308] [<c04684d8>] (ip6_finish_output2) from [<c046c344>] 
(ip6_output+0xb0/0x184)
[   12.298304] [<c046c344>] (ip6_output) from [<c048aa90>] 
(mld_sendpack+0x3c8/0x4b8)
[   12.305851] [<c048aa90>] (mld_sendpack) from [<c048b3d4>] 
(mld_ifc_timer_expire+0x1d4/0x300)
[   12.314284] [<c048b3d4>] (mld_ifc_timer_expire) from [<c006ba44>] 
(call_timer_fn.isra.25+0x24/0x98)
[   12.323301] [<c006ba44>] (call_timer_fn.isra.25) from [<c006bc6c>] 
(run_timer_softirq+0x1b4/0x260)
[   12.332239] [<c006bc6c>] (run_timer_softirq) from [<c0026590>] 
(__do_softirq+0x120/0x238)
[   12.340391] [<c0026590>] (__do_softirq) from [<c0026948>] 
(irq_exit+0xc0/0xfc)
[   12.347599] [<c0026948>] (irq_exit) from [<c005e6bc>] 
(__handle_domain_irq+0x80/0xec)

or

[   12.548824] [<c04da1b8>] (ieee802154_stop_queue) from [<c04d6d64>] 
(ieee802154_tx+0x6c/0x170)
[   12.557326] [<c04d6d64>] (ieee802154_tx) from [<c03d30e4>] 
(dev_hard_start_xmit+0x224/0x304)
[   12.565745] [<c03d30e4>] (dev_hard_start_xmit) from [<c03ec118>] 
(sch_direct_xmit+0xc4/0x1f4)
[   12.574241] [<c03ec118>] (sch_direct_xmit) from [<c03d3368>] 
(__dev_queue_xmit+0x1a4/0x4c4)
[   12.582569] [<c03d3368>] (__dev_queue_xmit) from [<c04d6484>] 
(lowpan_xmit+0x2a8/0x33c)
[   12.590556] [<c04d6484>] (lowpan_xmit) from [<c03d30e4>] 
(dev_hard_start_xmit+0x224/0x304)
[   12.598803] [<c03d30e4>] (dev_hard_start_xmit) from [<c03d35e8>] 
(__dev_queue_xmit+0x424/0x4c4)
[   12.607482] [<c03d35e8>] (__dev_queue_xmit) from [<c04684d8>] 
(ip6_finish_output2+0x1a0/0x5b4)
[   12.616074] [<c04684d8>] (ip6_finish_output2) from [<c046c344>] 
(ip6_output+0xb0/0x184)
[   12.624071] [<c046c344>] (ip6_output) from [<c048aa90>] 
(mld_sendpack+0x3c8/0x4b8)
[   12.631619] [<c048aa90>] (mld_sendpack) from [<c048d484>] 
(ipv6_mc_dad_complete+0x2c/0x54)
[   12.639864] [<c048d484>] (ipv6_mc_dad_complete) from [<c04736f8>] 
(addrconf_dad_completed+0x100/0x1ac)
[   12.649147] [<c04736f8>] (addrconf_dad_completed) from [<c047398c>] 
(addrconf_dad_work+0x1e8/0x338)
[   12.658190] [<c047398c>] (addrconf_dad_work) from [<c0036fa0>] 
(process_one_work+0x120/0x330)
[   12.666687] [<c0036fa0>] (process_one_work) from [<c00371fc>] 
(worker_thread+0x4c/0x480)
[   12.674756] [<c00371fc>] (worker_thread) from [<c003beb0>] 
(kthread+0xdc/0xf4)
[   12.681967] [<c003beb0>] (kthread) from [<c000f4a0>] 
(ret_from_fork+0x14/0x34)
[   12.689157] Code: e58d3004 e59d4004 e1540005 0a00000d (e594303c)
[   12.695350] ---[ end trace 598762c22717a96a ]---
[   12.699952] Kernel panic - not syncing: Fatal exception in interrupt

- Simon

On 18/05/15 15:00, Alexander Aring wrote:
> Hi Simon,
>
> On Mon, May 18, 2015 at 11:57:19AM +0100, Simon Vincent wrote:
>> Hi Alex,
>>
>> I can confirm your patch still results in the bad paging request.
>> Maybe you are not seeing it as you have a slightly different setup.
>>
>> If I understand correctly you have two virtual phys going to a single wpan
>> interface
>> e.g.
>> phy0 -> wpan0
>> phy1 -> wpan0
>>
>> My setup is two separate transceivers. Each with its own phy and wpan
>> interface.
>> e.g.
>> phy0 -> wpan0
>> phy1 -> wpan1
>>
>  From view of mac802154 layer this setup should be the same. Both running
> two times alloc_hw and register_hw for alloc/register a wpan phy. The
> driver layer is different.
>
> With your solution to putting the worker resource on the heap then the
> problem is solved?
>
> Can you provide more information about the "bad paging request" issue? A
> stacktrace or something else?
>
> I currently have no idea why you have this issue.
>
> - Alex

