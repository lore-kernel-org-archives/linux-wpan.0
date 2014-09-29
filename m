Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:56990 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109AbaI2QmG (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Sep 2014 12:42:06 -0400
Received: by mail-we0-f173.google.com with SMTP id p10so3904798wes.18
        for <linux-wpan@vger.kernel.org>; Mon, 29 Sep 2014 09:42:04 -0700 (PDT)
Date: Mon, 29 Sep 2014 18:41:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: ICMPv6 Redirects
Message-ID: <20140929164157.GA17633@omega>
References: <5429441C.5000302@gmail.com>
 <5429466F.4080506@gmail.com>
 <54295556.3030800@xsilon.com>
 <20140929131200.GA14608@omega>
 <20140929133048.GB14608@omega>
 <54295FA9.8030506@xsilon.com>
 <20140929133841.GA15176@omega>
 <542963F7.4030903@xsilon.com>
 <20140929135759.GA15411@omega>
 <542968C5.7000505@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <542968C5.7000505@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org

Hi Simon,

On Mon, Sep 29, 2014 at 03:12:21PM +0100, Simon Vincent wrote:
> 
> On 29/09/14 14:58, Alexander Aring wrote:
> >On Mon, Sep 29, 2014 at 02:51:51PM +0100, Simon Vincent wrote:
> >>Sorry for the confusion. My problem is I am receiving all packets.
> >>PACKET_OTHERHOST does not seem to be dropped. A suggestion from Varka was to
> >>disable redirects however it now seems that this is not possible on a ipv6
> >>interface.
> >>
> >>I can fix the problem by dropping PACKET_OTHERHOST in mac802154_subif_frame.
> >The first what IPv6 does is [0].
> >
> >See my previous mail. Also that we should handle on 6LoWPAN packet
> >handler function for receiving "lowpan_rcv" we should do the same,
> >otherwise we parsing PACKET_OTHERHOST sk_buff's and drop these directly
> >in IPv6 layer, which makes no sense.
> >
> >But what I see is that the current behaviour should also work.
> >Instrument the IPv6 delivery function and be sure that the information
> >about PACKET_OTHERHOST was not dropped.
> I do not catch any PACKET_OTHERHOST packets in the ip6_input.c ipv6_rcv
> function.
> I don't think the packets get this far. Also in the ieee802154_rcv function
> they are dropped. I will add some more debug to find where the redirects
> come from.

please try this:


diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 142eef5..002cd7c 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -189,7 +189,6 @@ static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
        skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
 
        new->protocol = htons(ETH_P_IPV6);
-       new->pkt_type = PACKET_HOST;
        new->dev = dev;
 
        raw_dump_table(__func__, "raw skb data dump before receiving",
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index 4413629..820922a 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -515,6 +515,9 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
        if (!netif_running(dev))
                goto drop_skb;
 
+       if (skb->pkt_type == PACKET_OTHERHOST)
+               goto drop_skb;
+
        if (dev->type != ARPHRD_IEEE802154)
                goto drop_skb;
 
@@ -524,7 +527,6 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
        /* check that it's our buffer */
        if (skb->data[0] == LOWPAN_DISPATCH_IPV6) {
                skb->protocol = htons(ETH_P_IPV6);
-               skb->pkt_type = PACKET_HOST;
 
                /* Pull off the 1-byte of 6lowpan header. */
                skb_pull(skb, 1);



should fix the issue, somebody overwrite the pkt_type skb attribute always
with PACKET_HOST, which is wrong.

Also we can first check this in lowpan_rcv and drop the skb when it's
not belong to us.

If you want to fix this mainline please seperate it in 3 patches, one
for generic 6lowpan, other ieee802154 6lowpan and one for the check on
PACKET_OTHERHOST in lowpan_rcv.

- Alex
