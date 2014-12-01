Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:41652 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752835AbaLAMdZ (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 1 Dec 2014 07:33:25 -0500
Message-ID: <1417437183.2703.45.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCHv2 bluetooth-next 0/2] 6lowpan: introduce nhc framework
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 01 Dec 2014 14:33:03 +0200
In-Reply-To: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
References: <1417295683-22682-1-git-send-email-alex.aring@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, kernel@pengutronix.de, Martin Townsend <mtownsend1973@gmail.com>, Marcel Holtmann <marcel@holtmann.org>

Hi Alex,

On la, 2014-11-29 at 22:14 +0100, Alexander Aring wrote:
> This patch series introduce the next header compression framework. Currently
> we support udp compression/uncompression only. This framework allow to add new
> next header compression formats easily.
> 
> If somebody wants to add a new header compression format and some information
> are missing while calling compression and uncompression callbacks. Please
> feel free to make framework changes according these callbacks.
> 
> Note:
> 
> If building 6lowpan_udp as module please make sure it's loaded before running
> rfc6282 udp connection. If it's not loaded we send 6lowpan with raw udp header
> and next header compression bit isn't set. Nevertheless if you use rfc6282
> connection and 6lowpan_udp isn't loaded following will be printed:
> 
> "ieee802154 wpan-phy0 wpan0: received nhc which is not supported. Dropping."
> 
> changes since v2:
>  - make udp nhc as module as suggested by Marcel Holtmann
>  - fix comment header in nhc_udp.c
> 
> I didn't make the lowpan_nhc declaration "const" because this will occur
> issues with rb_node, id and idmask array. Which will manipulated during
> runtime.
> 


Tested it between two BT 6lowpan connections. If both ends load the
6lowpan_udp module, then no issues. If only the other end has loaded the
module, the other end (receiving end) crashed.


[  132.417733] (NULL net_device): received nhc which is not supported.
Dropping.
[  132.722432] skbuff: skb_under_panic: text:d19cb60c len:55 put:40
head:cd923000 data:cd922fec tail:0xcd923023 end:0xcd923740 dev:<NULL>
[  133.536256] ------------[ cut here ]------------
[  133.537233] kernel BUG at 3.16+gitAUTOINC
+f6af675ef5-r215/linux/net/core/skbuff.c:100!
[  133.537233] invalid opcode: 0000 [#1] PREEMPT SMP 
[  133.537233] Modules linked in: bluetooth_6lowpan 6lowpan nfc ecb
btusb bluetooth rfkill snd_intel8x0 ohci_pci snd_ac97_codec ac97_bus
parport_pc parport uvesafb
[  133.537233] CPU: 0 PID: 327 Comm: kworker/u3:0 Not tainted
3.17.0-bt6lowpan #1
[  133.537233] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS
VirtualBox 12/01/2006
[  133.537233] Workqueue: hci0 hci_rx_work [bluetooth]
[  133.537233] task: c0170000 ti: cc7d0000 task.ti: cc7d0000
[  133.537233] EIP: 0060:[<c1779838>] EFLAGS: 00010292 CPU: 0
[  133.537233] EIP is at skb_panic+0x68/0x70
[  133.537233] EAX: 0000007a EBX: cd923000 ECX: 00000000 EDX: 00000001
[  133.537233] ESI: c1b2a11b EDI: 00000004 EBP: cc7d1c18 ESP: cc7d1be8
[  133.537233]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[  133.537233] CR0: 8005003b CR2: b76d9000 CR3: 0e1e5000 CR4: 000006d0
[  133.537233] Stack:
[  133.537233]  c1ba8748 c1982e68 d19cb60c 00000037 00000028 cd923000
cd922fec cd923023
[  133.537233]  cd923740 c1b2a11b cd914300 00000003 cc7d1c24 c1779881
c1982e68 cc7d1c94
[  133.537233]  d19cb60c c0304c48 00000003 00000008 cc7d1c40 00000003
017d1c64 00000003
[  133.537233] Call Trace:
[  133.537233]  [<d19cb60c>] ? lowpan_header_decompress+0x26c/0x980
[6lowpan]
[  133.537233]  [<c1779881>] skb_push+0x41/0x50
[  133.537233]  [<d19cb60c>] lowpan_header_decompress+0x26c/0x980
[6lowpan]
[  133.537233]  [<d19daeb4>] chan_recv_cb+0x244/0x3f0
[bluetooth_6lowpan]
[  133.537233]  [<d1738711>] l2cap_data_channel+0x8e1/0x980 [bluetooth]
[  133.537233]  [<c10772d9>] ? sched_clock_local+0x49/0x180
[  133.537233]  [<d173aa8f>] l2cap_recv_frame+0xbf/0x2ee0 [bluetooth]
[  133.537233]  [<c100a7a8>] ? sched_clock+0x8/0x10
[  133.537233]  [<c10772d9>] ? sched_clock_local+0x49/0x180
[  133.537233]  [<c100a7a8>] ? sched_clock+0x8/0x10
[  133.537233]  [<c10772d9>] ? sched_clock_local+0x49/0x180
[  133.537233]  [<c107770f>] ? sched_clock_cpu+0x10f/0x160
[  133.537233]  [<c10729cb>] ? get_parent_ip+0xb/0x40
[  133.537233]  [<c1072a4b>] ? preempt_count_add+0x4b/0xa0
[  133.537233]  [<c13e0112>] ? debug_smp_processor_id+0x12/0x20
[  133.537233]  [<c108e584>] ? get_lock_stats+0x24/0x40
[  133.537233]  [<c1090a34>] ? mark_held_locks+0x64/0x90
[  133.537233]  [<c189dbfd>] ? __mutex_unlock_slowpath+0xcd/0x1b0
[  133.537233]  [<c13e012f>] ? __this_cpu_preempt_check+0xf/0x20
[  133.537233]  [<c1090b54>] ? trace_hardirqs_on_caller+0xf4/0x240
[  133.537233]  [<c108e326>] ? trace_hardirqs_off_caller+0xb6/0x160
[  133.537233]  [<d173ee19>] l2cap_recv_acldata+0x2f9/0x340 [bluetooth]
[  133.537233]  [<d1709a93>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
[  133.537233]  [<d1709ce9>] hci_rx_work+0x369/0x4a0 [bluetooth]
[  133.537233]  [<d1709a93>] ? hci_rx_work+0x113/0x4a0 [bluetooth]
[  133.537233]  [<c1063203>] process_one_work+0x1b3/0x4e0
[  133.537233]  [<c1063163>] ? process_one_work+0x113/0x4e0
[  133.537233]  [<c10638c9>] worker_thread+0x39/0x440
[  133.537233]  [<c1063890>] ? init_pwq+0xc0/0xc0
[  133.537233]  [<c1067ce8>] kthread+0xa8/0xc0
[  133.537233]  [<c1090cab>] ? trace_hardirqs_on+0xb/0x10
[  133.537233]  [<c18a1741>] ret_from_kernel_thread+0x21/0x30
[  133.537233]  [<c1067c40>] ? kthread_create_on_node+0x160/0x160
[  133.537233] Code: 98 a8 00 00 00 89 54 24 10 89 5c 24 14 8b 40 5c 89
4c 24 08 c7 04 24 48 87 ba c1 89 44 24 0c 8b 45 08 89 44 24 04 e8 b0 db
11 00 <0f> 0b 8d b6 00 00 00 00 55 89 e5 83 ec 04 3e 8d 74 26 00 89 c1
[  133.537233] EIP: [<c1779838>] skb_panic+0x68/0x70 SS:ESP
0068:cc7d1be8


Just wondering about how it works now. If the device does not have
6lowpan_nhc module loaded, then UDP compressed packets are dropped. This
feels wrong and is a kind of regression to the previous way of working,
at least we need to auto-load the compression module.

How the system works if there would be another way to compress UDP
packets. User would need to know somehow what kind of packets it is
suppose to send/receive and load corresponding module. I wonder if this
kind of knowledge is really possible in practice. Should we always
support the NHC defined in https://tools.ietf.org/html/rfc6282 and then
have a way to load correct compression "plugin" if we get a packet with
different compression scheme.

If the system does not support https://tools.ietf.org/html/rfc6775 (like
at the moment) there is no way to figure out what compression system the
other end is using/supporting. In this respect, it would be nice if the
current way of working would be automatically supported and user would
not need to remember to select 6lowpan_nhc option when building the
kernel.

I like the way to support different compression algorithms, it just
needs some fine tuning.


Cheers,
Jukka


