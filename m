Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36746 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbbDHKa1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Apr 2015 06:30:27 -0400
Received: by wizk4 with SMTP id k4so49449853wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 08 Apr 2015 03:30:26 -0700 (PDT)
Date: Wed, 8 Apr 2015 12:30:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Raw ieee802154 socket
Message-ID: <20150408103017.GA1028@omega>
References: <5524ECA8.7000500@sssup.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5524ECA8.7000500@sssup.it>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Matteo Petracca <matteo.petracca@sssup.it>
Cc: linux-wpan@vger.kernel.org

Hi,

On Wed, Apr 08, 2015 at 10:54:00AM +0200, Matteo Petracca wrote:
> Dear all,
> I want to create a raw ieee802154 socket, and I'm
> following the test1.c example of lowpan-tools.
> 

I need to admit, I never used the socket functionality extremely and I
can't guarantee that this is fully working.

This should be a new entry on the "Open Task" list...

> I succeeded in sending data packets, when I put in the buffer
> a packet (header+payload) it is sent trough the channel as it
> is (I checked with the sniffer). When I receive a data packet
> I get in the buffer only the payload, without the header. Is there
> any way to get back the header too?
> 
1.
yea, I know why this happens (maybe)... because the frame is parsed into the
"not fully supported parsing mechanism" which drops frames which we
don't currently supported like cmd, beacons, etc. See [1], this is the
reason why you receive dataframes only. Solution would be to insert
stuff to parse other frameformats, but I planed a rework of the full
parsing frame stuff.

2.
The reason why you don't see the mac header is maybe because that [2]
will skip the header. On a raw socket this should be recovered by a
skb_push at [3] after share check, then we are sure that the skb is
not shared anymore.

A shoot into the dark would be:

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index b60c65f..c1c0681 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -365,6 +365,8 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
        if (!skb)
                return NET_RX_DROP;
 
+       skb_push(skb, skb->mac_len);
+
        if (sock_queue_rcv_skb(sk, skb) < 0) {
                kfree_skb(skb);
                return NET_RX_DROP;


and hopefully that doesn't occur other sideeffects for later parsing mechanism
and the "start" buffer was not overwritten before.

If you test it then please let us know if it's working or not.  For my
knowledge is that we want also raw frames on receiving and I would
accept patches for this.




Another question would be "What exactly do you want to do". With the
above situation you see frames which belongs to your node only (matching
address, etc.). Or if you want to have "everything" raw inside
userspace also frames which doesn't belong to your node, but this would
be more complicated, then it's some kind of monitor interface in
promiscous mode which allow transmit handling. Some transceiver
disable AACK handling in promiscous mode so monitor interface with send
functionality would be never supported. :-(

> I am using kernel 3.8.
> 

Such an old kernel? There are some fixed bugs, it's recommended to use
bluetooth-next with wpan-tools, see [0]. I also believe that the upper
diff doesn't apply anymore on this release. :-)

- Alex

[0] http://wpan.cakelab.org/
[1] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/mac802154/rx.c#n104
[2] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/ieee802154/header_ops.c#n266
[3] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/ieee802154/socket.c#n362
