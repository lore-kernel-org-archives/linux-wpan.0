Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38931 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbaLAPBk (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Dec 2014 10:01:40 -0500
Date: Mon, 1 Dec 2014 16:01:35 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 0/2] 6lowpan: introduce nhc framework
Message-ID: <20141201150132.GB996@omega>
References: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
 <1417437183.2703.45.camel@jrissane-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1417437183.2703.45.camel@jrissane-mobl.ger.corp.intel.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>

Hi Jukka,

On Mon, Dec 01, 2014 at 02:33:03PM +0200, Jukka Rissanen wrote:
> Hi Alex,
> 
> On la, 2014-11-29 at 22:14 +0100, Alexander Aring wrote:
> > This patch series introduce the next header compression framework. Currently
> > we support udp compression/uncompression only. This framework allow to add new
> > next header compression formats easily.
> > 
> > If somebody wants to add a new header compression format and some information
> > are missing while calling compression and uncompression callbacks. Please
> > feel free to make framework changes according these callbacks.
> > 
> > Note:
> > 
> > If building 6lowpan_udp as module please make sure it's loaded before running
> > rfc6282 udp connection. If it's not loaded we send 6lowpan with raw udp header
> > and next header compression bit isn't set. Nevertheless if you use rfc6282
> > connection and 6lowpan_udp isn't loaded following will be printed:
> > 
> > "ieee802154 wpan-phy0 wpan0: received nhc which is not supported. Dropping."
> > 
> > changes since v2:
> >  - make udp nhc as module as suggested by Marcel Holtmann
> >  - fix comment header in nhc_udp.c
> > 
> > I didn't make the lowpan_nhc declaration "const" because this will occur
> > issues with rb_node, id and idmask array. Which will manipulated during
> > runtime.
> > 
> 
> 
> Tested it between two BT 6lowpan connections. If both ends load the
> 6lowpan_udp module, then no issues. If only the other end has loaded the
> module, the other end (receiving end) crashed.
> 
> 
> [  132.417733] (NULL net_device): received nhc which is not supported.
> Dropping.
> [  132.722432] skbuff: skb_under_panic: text:d19cb60c len:55 put:40
> head:cd923000 data:cd922fec tail:0xcd923023 end:0xcd923740 dev:<NULL>
> [  133.536256] ------------[ cut here ]------------
> [  133.537233] kernel BUG at 3.16+gitAUTOINC
> +f6af675ef5-r215/linux/net/core/skbuff.c:100!
> [  133.537233] invalid opcode: 0000 [#1] PREEMPT SMP 
> [  133.537233] Modules linked in: bluetooth_6lowpan 6lowpan nfc ecb
> btusb bluetooth rfkill snd_intel8x0 ohci_pci snd_ac97_codec ac97_bus
> parport_pc parport uvesafb
> [  133.537233] CPU: 0 PID: 327 Comm: kworker/u3:0 Not tainted
> 3.17.0-bt6lowpan #1
> [  133.537233] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
> VirtualBox 12/01/2006
> [  133.537233] Workqueue: hci0 hci_rx_work [bluetooth]
> [  133.537233] task: c0170000 ti: cc7d0000 task.ti: cc7d0000
> [  133.537233] EIP: 0060:[<c1779838>] EFLAGS: 00010292 CPU: 0
> [  133.537233] EIP is at skb_panic+0x68/0x70
> [  133.537233] EAX: 0000007a EBX: cd923000 ECX: 00000000 EDX: 00000001
> [  133.537233] ESI: c1b2a11b EDI: 00000004 EBP: cc7d1c18 ESP: cc7d1be8
> [  133.537233]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
> [  133.537233] CR0: 8005003b CR2: b76d9000 CR3: 0e1e5000 CR4: 000006d0
> [  133.537233] Stack:
> [  133.537233]  c1ba8748 c1982e68 d19cb60c 00000037 00000028 cd923000
> cd922fec cd923023
> [  133.537233]  cd923740 c1b2a11b cd914300 00000003 cc7d1c24 c1779881
> c1982e68 cc7d1c94
> [  133.537233]  d19cb60c c0304c48 00000003 00000008 cc7d1c40 00000003
> 017d1c64 00000003
> [  133.537233] Call Trace:
> [  133.537233]  [<d19cb60c>] ? lowpan_header_decompress+0x26c/0x980
> [6lowpan]
> [  133.537233]  [<c1779881>] skb_push+0x41/0x50
> [  133.537233]  [<d19cb60c>] lowpan_header_decompress+0x26c/0x980
> [6lowpan]
> [  133.537233]  [<d19daeb4>] chan_recv_cb+0x244/0x3f0
> [bluetooth_6lowpan]
> [  133.537233]  [<d1738711>] l2cap_data_channel+0x8e1/0x980 [bluetooth]
> [  133.537233]  [<c10772d9>] ? sched_clock_local+0x49/0x180
> [  133.537233]  [<d173aa8f>] l2cap_recv_frame+0xbf/0x2ee0 [bluetooth]
> [  133.537233]  [<c100a7a8>] ? sched_clock+0x8/0x10
> [  133.537233]  [<c10772d9>] ? sched_clock_local+0x49/0x180
> [  133.537233]  [<c100a7a8>] ? sched_clock+0x8/0x10
> [  133.537233]  [<c10772d9>] ? sched_clock_local+0x49/0x180
> [  133.537233]  [<c107770f>] ? sched_clock_cpu+0x10f/0x160
> [  133.537233]  [<c10729cb>] ? get_parent_ip+0xb/0x40
> [  133.537233]  [<c1072a4b>] ? preempt_count_add+0x4b/0xa0
> [  133.537233]  [<c13e0112>] ? debug_smp_processor_id+0x12/0x20
> [  133.537233]  [<c108e584>] ? get_lock_stats+0x24/0x40
> [  133.537233]  [<c1090a34>] ? mark_held_locks+0x64/0x90
> [  133.537233]  [<c189dbfd>] ? __mutex_unlock_slowpath+0xcd/0x1b0
> [  133.537233]  [<c13e012f>] ? __this_cpu_preempt_check+0xf/0x20
> [  133.537233]  [<c1090b54>] ? trace_hardirqs_on_caller+0xf4/0x240
> [  133.537233]  [<c108e326>] ? trace_hardirqs_off_caller+0xb6/0x160
> [  133.537233]  [<d173ee19>] l2cap_recv_acldata+0x2f9/0x340 [bluetooth]
> [  133.537233]  [<d1709a93>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
> [  133.537233]  [<d1709ce9>] hci_rx_work+0x369/0x4a0 [bluetooth]
> [  133.537233]  [<d1709a93>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
> [  133.537233]  [<c1063203>] process_one_work+0x1b3/0x4e0
> [  133.537233]  [<c1063163>] ? process_one_work+0x113/0x4e0
> [  133.537233]  [<c10638c9>] worker_thread+0x39/0x440
> [  133.537233]  [<c1063890>] ? init_pwq+0xc0/0xc0
> [  133.537233]  [<c1067ce8>] kthread+0xa8/0xc0
> [  133.537233]  [<c1090cab>] ? trace_hardirqs_on+0xb/0x10
> [  133.537233]  [<c18a1741>] ret_from_kernel_thread+0x21/0x30
> [  133.537233]  [<c1067c40>] ? kthread_create_on_node+0x160/0x160
> [  133.537233] Code: 98 a8 00 00 00 89 54 24 10 89 5c 24 14 8b 40 5c 89
> 4c 24 08 c7 04 24 48 87 ba c1 89 44 24 0c 8b 45 08 89 44 24 04 e8 b0 db
> 11 00 <0f> 0b 8d b6 00 00 00 00 55 89 e5 83 ec 04 3e 8d 74 26 00 89 c1
> [  133.537233] EIP: [<c1779838>] skb_panic+0x68/0x70 SS:ESP
> 0068:cc7d1be8
> 

Ok I send now a correction for patch PATCH 1/2 for use "-ENOENT" as ret
initialization. Can you test that, please? :-)

> 
> Just wondering about how it works now. If the device does not have
> 6lowpan_nhc module loaded, then UDP compressed packets are dropped. This
> feels wrong and is a kind of regression to the previous way of working,
> at least we need to auto-load the compression module.

It works now in this way (example UDP, RAW UDP is a normal 8 byte UDP header):

If no 6lowpan_nhc_udp is loaded:

sending side:

We don't set the NHC bit in 6LoWPAN header, we putting the RAW UDP header.

receiving side:

If we get a 6LoWPAN header which set the NHC bit:
We print a warning and drop the packet, because we don't know the NHC ID.
"ieee802154 wpan-phy0 wpan0: received nhc which is not supported. Dropping."
Maybe this can look a little bit better. :-)

If we get a 6LoWPAN header which does not set the NHC bit and contains
the raw UDP header then this will go into IPv6 layer.




If 6lowpan_nhc_udp is loaded:

sending side:
If we get nexthdr == UDP then automatically we do a udp compression
algorithm for RFC6282.

receiving side:

We can now accept boths methods, NHC bit is set and UDP compression
(rfc6282) then magic 6lowpan_nhc_udp module function do an
uncompression.

If NHC bit isn't set we accept also a RAW udp without compression.

> 
> How the system works if there would be another way to compress UDP
> packets. User would need to know somehow what kind of packets it is
> suppose to send/receive and load corresponding module. I wonder if this
> kind of knowledge is really possible in practice. Should we always
> support the NHC defined in https://tools.ietf.org/html/rfc6282 and then
> have a way to load correct compression "plugin" if we get a packet with
> different compression scheme.
> 
> If the system does not support https://tools.ietf.org/html/rfc6775 (like
> at the moment) there is no way to figure out what compression system the
> other end is using/supporting. In this respect, it would be nice if the
> current way of working would be automatically supported and user would
> not need to remember to select 6lowpan_nhc option when building the
> kernel.
> 

Yes, we should support automatically and not by user if he loads the
corresponding module.

For configuration the compression methods I would expect some kind of
netlink interface. On the userspace side we need some kind of tool to
make it configurable. What do you think here?

Supporting a new userspace tool will make a high working load and we
need some kind of new 6lowpan repo for releasing such tool. I _could_ try
to implement such netlink interface for nhc into net/6lowpan and greating
a userspace tool. Don't know if we do this effort and making a 6lowpan_udp
userspace tool for configuration, but please make first such framework
mainline and the netlink interface can we add later. :-)


btw: which part of rfc6775 describes how to detect the compression
methods on the other end (using/supporting)?

> I like the way to support different compression algorithms, it just
> needs some fine tuning.
> 

Yea, this should mainly _first_ bring any framework for next header
compression mainline. I didn't program such framework in my life and
don't know what 100% we need. For adding new compression methods I think
this framework will grow automatically by history of hacking new
compression methods and I am sure lot of things can be do better than
right now. At the moment it's better than the current behaviour that we
don't have such framework for adding new compression methods.

- Alex
