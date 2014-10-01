Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:61110 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbaJAPYU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Oct 2014 11:24:20 -0400
Message-ID: <542C1C96.80605@xsilon.com>
Date: Wed, 01 Oct 2014 16:24:06 +0100
From: Martin Townsend <martin.townsend@xsilon.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bluetooth] Fix lowpan_rcv
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com> <1412174827.4860.144.camel@jrissane-mobl.ger.corp.intel.com>
In-Reply-To: <1412174827.4860.144.camel@jrissane-mobl.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>, Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Jukka,

I spotted one thing in recv_pkt when skb_copy_expand fails it should goto drop but this is not what you are seeing.  This also exists in 6lowpan_rtnl.c so I will fix this in both for the next patch.

I would be interested to know if the 802.15.4 wireless guys are seeing this to narrow this down.  I don't see this but then I had to manually add the code into my bluetooth tree from ours due to differences so I could have well screwed something up.

- Martin.

On 01/10/14 15:47, Jukka Rissanen wrote:
> Hi Martin,
>
> just in case add me to cc: next time so I do not miss these 6lowpan
> patches.
>
> On ke, 2014-10-01 at 13:10 +0100, Martin Townsend wrote:
>> This series aims to fix incorrect return values in lowpan_rcv
>> To achieve this it also refactors the receive path to
>>   1) free skb only from lowpan_rcv and not functions that it calls
>>   2) move skb delivery from IPHC
>>
>> I have only compile tested the changes for bluetooth as I don't have any HW
>> available so would be grateful for any testing from the Bluetooth developers.
>> I have done some minimal testing for IEEE802.15.4
> FYI, I tried this with latest bluetooth-next tree and got following oops
> when trying to connect to peer bt 6lowpan device. The system probably
> crashed before any packet was delivered to peer as I did not see
> anything on the other end of the connection.
>
>
> BUG: unable to handle kernel NULL pointer dereference at 000000a0
> IP: [<c17712c3>] __netif_receive_skb_core+0xa3/0x7b0
> *pde = 00000000 
> Oops: 0000 [#1] PREEMPT SMP 
> Modules linked in: bluetooth_6lowpan 6lowpan rfcomm bnep ecb btusb
> bluetooth nfc rfkill snd_intel8x0 ohci_pci snd_ac97_codec ac97_bus
> parport_pc parport
> CPU: 0 PID: 353 Comm: systemd-network Not tainted 3.17.0-rc1-bt6lowpan
> #1
> Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox
> 12/01/2006
> task: ccb695e0 ti: cc88e000 task.ti: cc88e000
> EIP: 0060:[<c17712c3>] EFLAGS: 00010282 CPU: 0
> EIP is at __netif_receive_skb_core+0xa3/0x7b0
> EAX: cd964900 EBX: cd964900 ECX: 00000000 EDX: 00000000
> ESI: cd964900 EDI: 00000001 EBP: cf00bf4c ESP: cf00bf18
>  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> CR0: 8005003b CR2: d0cd6040 CR3: 0d057000 CR4: 000006d0
> Stack:
>  00000002 00000000 00000000 c1771279 cf73e698 cf00bf00 00000000 00000001
>  cd964900 00000046 cd964900 00000000 cf73e698 cf00bf5c c17719eb cd964900
>  00000000 cf00bf80 c177300f cf73e664 cf73e670 00000040 cf73e5d4 cf73e698
> Call Trace:
>  [<c1771279>] ? __netif_receive_skb_core+0x59/0x7b0
>  [<c17719eb>] __netif_receive_skb+0x1b/0x70
>  [<c177300f>] process_backlog+0x9f/0x140
>  [<c1772e48>] net_rx_action+0x128/0x250
>  [<c104fd84>] __do_softirq+0xd4/0x300
>  [<c104fcb0>] ? __local_bh_enable_ip+0xf0/0xf0
>  [<c10049fc>] do_softirq_own_stack+0x2c/0x40
>  <IRQ> 
>  [<c1050136>] irq_exit+0x86/0xb0
>  [<c188bd98>] smp_apic_timer_interrupt+0x38/0x50
>  [<c188b6ce>] apic_timer_interrupt+0x32/0x38
> Code: 00 31 c9 c7 44 24 04 00 00 00 00 c7 04 24 02 00 00 00 31 d2 b8 14
> 42 c0 c1 e8 0a 1f 92 ff c7 45 e8 01 00 00 00 8b 45 ec 8b 50 14 <8b> 92
> a0 00 00 00 89 50 74 b8 f8 7c ad c1 e8 1a f7 c5 ff 8b 5d
> EIP: [<c17712c3>] __netif_receive_skb_core+0xa3/0x7b0 SS:ESP
> 0068:cf00bf18
> CR2: 00000000000000a0
> ---[ end trace 704a740b1671072d ]---
> Kernel panic - not syncing: Fatal exception in interrupt
> Kernel Offset: 0x0 from 0xc1000000 (relocation range:
> 0xc0000000-0xd07effff)
> ---[ end Kernel panic - not syncing: Fatal exception in interrupt
>
>
>
> Cheers,
> Jukka
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

