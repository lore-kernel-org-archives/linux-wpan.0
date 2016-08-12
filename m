Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:41553 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752372AbcHLQ3F (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Fri, 12 Aug 2016 12:29:05 -0400
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_Problems_about_handling_duplicate?=
 =?UTF-8?Q?_packets_when_frame_retry_is_enabled?=
References: <576133E7D398244EA0325FF7CE2A09E5CD55E15B@G08CNEXMBPEKD03.g08.fujitsu.local>
 <177f2368-0a94-079e-09ec-1093e62e5874@pengutronix.de>
 <576133E7D398244EA0325FF7CE2A09E5CD55E4B8@G08CNEXMBPEKD03.g08.fujitsu.local>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <af477ae0-0dd1-cc21-86c2-40f99d86a14a@pengutronix.de>
Date: Fri, 12 Aug 2016 18:29:03 +0200
MIME-Version: 1.0
In-Reply-To: <576133E7D398244EA0325FF7CE2A09E5CD55E4B8@G08CNEXMBPEKD03.g08.fujitsu.local>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Xue, Wenqian" <xuewenqian@cn.fujitsu.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


Hi,

On 08/11/2016 11:50 AM, Xue, Wenqian wrote:
> Hi, Alexander,
> 
> Thank you for your quick reply.
> I'm not sure if AACK is disabled (how can I know it?), but I'm using node interface not monitor interface.
>

yea, I should get it before because monitor interfaces doesn't run the
code which you changed. But monitor interfaces goes into promiscuous
mode and AACK is disabled there.

> When without kernel modification and setting frame retries=3 for both RPis, lots of error 'sequence number did not match" will occur. While, when with the modification to deal with duplicates, the error will not occur any more. I'm not sure if AACK could discard duplicates automatically.
> Thank you!
> 

Your modification handles in duplicates in a form which is not
acceptable. It will simple drop duplicates but how frame retries works
is the following:

1. Node A transmits frame for Node B with ackrequest bit set.
2. Node B receive that frame and see's "ackrequest bit is set" and
   sending an ACK back.
3. If Node A received an ack for the sequence number then no
   retransmission will occur.
OR
3. If Node A doesn't received an ack it will retransmit the frame.


On your nodes and if you are really using two at86rf233 transceivers,
this mechanism is completely done by hardware.

Transmit: ARET
Receive: AACK

On the receive side it's always imporant that the receiving node
supports AACK handling if Nodes sending frames with "ackrequest bit"
set.

---

First, you should sniff somehow the traffic if it's possible, to see
what's going on the traffic and you see that Node B sends ACKs back, if
not -> missing AACK handling.

On linux the openlabs transceiver (at86rf233) supports AACK handling...
don't know if you break it with your changes.

---

Also I detected that the ieee802154 sockets doesn't care about "iwpan
dev wpan0 set ackreq_default" setting [0]. This socket interface should
only be used as DGRAM sockets and there is a big TODO to make an
enhanced version of this socket interface. :-)

But that you have retransmits smells that the [0] is set.

---

I am here totally confused that you don't have AACK handling which the
at86rf233 supports, do you really using two openlabs with mainline Linux
kernel? Or do you talking with some contiki/RIOT etc. node?

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/socket.c#L667
