Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:27917 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448AbaJBNzS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Thu, 2 Oct 2014 09:55:18 -0400
Message-ID: <1412258111.13121.35.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH v4 bluetooth] Fix lowpan_rcv
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Thu, 02 Oct 2014 16:55:11 +0300
In-Reply-To: <542D4232.2070303@xsilon.com>
References: <1412165422-31063-1-git-send-email-martin.townsend@xsilon.com>
		 <1412174827.4860.144.camel@jrissane-mobl.ger.corp.intel.com>
		 <542C1C96.80605@xsilon.com>
	 <1412249319.13121.26.camel@jrissane-mobl.ger.corp.intel.com>
	 <542D4232.2070303@xsilon.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-zigbee-devel@lists.sourceforge.net, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, alex.aring@gmail.com

Hi Martin,

On to, 2014-10-02 at 13:16 +0100, Martin Townsend wrote:
> Hi Jukka,
> 
> Thanks for investigating this. 
> 
> If you set the dev in your receive function does the oops go away,  BTW this is where the pkt_type is set to PACKET_HOST, for us this was causing problems, I don't know if this is the same for you guys.
> 
> Here's the code:
> 
>             local_skb->protocol = htons(ETH_P_IPV6);
> >>>     local_skb->dev = dev;
>             local_skb->pkt_type = PACKET_HOST;
> 
>             if (give_skb_to_upper(local_skb, dev)
>                             != NET_RX_SUCCESS) {
>                 kfree_skb(local_skb);
> 
> - Martin.

So I applied this patch

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index e4f5ce5..aa64f91 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -323,6 +323,7 @@ static int recv_pkt(struct sk_buff *skb, struct
net_device *dev,
 
                local_skb->protocol = htons(ETH_P_IPV6);
                local_skb->pkt_type = PACKET_HOST;
+               local_skb->dev = dev;
 
                if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS)
{
                        goto drop_local_skb;
@@ -362,6 +363,7 @@ static int recv_pkt(struct sk_buff *skb, struct
net_device *dev,
 
                        local_skb->protocol = htons(ETH_P_IPV6);
                        local_skb->pkt_type = PACKET_HOST;
+                       local_skb->dev = dev;
 
                        if (give_skb_to_upper(local_skb, dev)
                                                        !=
NET_RX_SUCCESS) {


and I do not see the earlier null pointer oops any more.


Unfortunately a new error is seen:

[  340.676353] inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
[  340.676353] kworker/u3:1/370 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  340.676353]  (&(&list->lock)->rlock#6){+.?...}, at: [<f8319d4c>]
hci_send_acl+0xac/0x290 [bluetooth]
[  340.676353] {IN-SOFTIRQ-W} state was registered at:
[  340.676353]   [<c10915a3>] __lock_acquire+0x6d3/0x1d20
[  340.676353]   [<c109325d>] lock_acquire+0x9d/0x140
[  340.676353]   [<c1889c25>] _raw_spin_lock+0x45/0x80
[  340.676353]   [<f8319d4c>] hci_send_acl+0xac/0x290 [bluetooth]
[  340.676353]   [<f833abf0>] l2cap_do_send+0x60/0x100 [bluetooth]
[  340.676353]   [<f833e7c0>] l2cap_chan_send+0x7f0/0x10e0 [bluetooth]
[  340.676353]   [<f850691e>] send_pkt+0x4e/0xa0 [bluetooth_6lowpan]
[  340.676353]   [<f8506d20>] bt_xmit+0x3b0/0x770 [bluetooth_6lowpan]
[  340.676353]   [<c17742f4>] dev_hard_start_xmit+0x344/0x670
[  340.676353]   [<c17749ad>] __dev_queue_xmit+0x38d/0x680
[  340.676353]   [<c1774caf>] dev_queue_xmit+0xf/0x20
[  340.676353]   [<c177b8b0>] neigh_connected_output+0x130/0x1a0
[  340.676353]   [<c1812a63>] ip6_finish_output2+0x173/0x8c0
[  340.676353]   [<c18182db>] ip6_finish_output+0x7b/0x1b0
[  340.676353]   [<c18184a7>] ip6_output+0x97/0x2a0
...

I have to investigate this more what your new code is doing as I did not
see this error earlier before your patch.

So I have very latest bluetooth-next (commit b57d4471fd18) + your v4
patch + above patch that sets the dev pointer, and this combination
triggers the above inconsistent softirq usage error.


Cheers,
Jukka


