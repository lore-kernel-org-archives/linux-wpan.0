Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:52065 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbaJGS6S (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Oct 2014 14:58:18 -0400
Date: Tue, 7 Oct 2014 20:58:10 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141007185807.GA12298@omega>
References: <1412696037-25111-1-git-send-email-martin.townsend@xsilon.com>
 <1412696037-25111-2-git-send-email-martin.townsend@xsilon.com>
 <20141007161420.GA2216@omega>
 <5434300C.6000602@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5434300C.6000602@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Martin,

On Tue, Oct 07, 2014 at 07:25:16PM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> On 07/10/14 17:14, Alexander Aring wrote:
> >Hi Martin,
> >
> >On Tue, Oct 07, 2014 at 04:33:57PM +0100, Martin Townsend wrote:
> >>Currently there are potentially 2 skb_copy_expand calls in IPHC
> >>decompression.  This patch replaces this with one call to
> >>pskb_expand_head.  It also checks to see if there is enough headroom
> >>first to ensure it's only done if necessary.
> >>As pskb_expand_head must only have one reference the calling code
> >>now ensures this.
> >>
> >>Signed-off-by: Martin Townsend <martin.townsend@xsilon.com>
> >>---
> >>  net/6lowpan/iphc.c            | 53 ++++++++++++++++++++++---------------------
> >>  net/bluetooth/6lowpan.c       | 19 ++++++++++++----
> >>  net/ieee802154/6lowpan_rtnl.c | 13 +++++++++++
> >>  3 files changed, 55 insertions(+), 30 deletions(-)
> >>
> >>diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> >>index 142eef5..fa8f348 100644
> >>--- a/net/6lowpan/iphc.c
> >>+++ b/net/6lowpan/iphc.c
> >>@@ -174,30 +174,22 @@ static int uncompress_context_based_src_addr(struct sk_buff *skb,
> >>  static int skb_deliver(struct sk_buff *skb, struct ipv6hdr *hdr,
> >>  		       struct net_device *dev, skb_delivery_cb deliver_skb)
> >>  {
> >>-	struct sk_buff *new;
> >>  	int stat;
> >>-	new = skb_copy_expand(skb, sizeof(struct ipv6hdr), skb_tailroom(skb),
> >>-			      GFP_ATOMIC);
> >>-	kfree_skb(skb);
> >>-
> >>-	if (!new)
> >>-		return -ENOMEM;
> >>-
> >>-	skb_push(new, sizeof(struct ipv6hdr));
> >>-	skb_reset_network_header(new);
> >>-	skb_copy_to_linear_data(new, hdr, sizeof(struct ipv6hdr));
> >>+	skb_push(skb, sizeof(struct ipv6hdr));
> >>+	skb_reset_network_header(skb);
> >>+	skb_copy_to_linear_data(skb, hdr, sizeof(struct ipv6hdr));
> >>-	new->protocol = htons(ETH_P_IPV6);
> >>-	new->pkt_type = PACKET_HOST;
> >>-	new->dev = dev;
> >>+	skb->protocol = htons(ETH_P_IPV6);
> >>+	skb->pkt_type = PACKET_HOST;
> >>+	skb->dev = dev;
> >>  	raw_dump_table(__func__, "raw skb data dump before receiving",
> >>-		       new->data, new->len);
> >>+		       skb->data, skb->len);
> >>-	stat = deliver_skb(new, dev);
> >>+	stat = deliver_skb(skb, dev);
> >>-	kfree_skb(new);
> >>+	kfree_skb(skb);
> >I know what before but "consume_skb"
> agreed.
> >>  	return stat;
> >>  }
> >>@@ -460,7 +452,6 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> >>  	/* UDP data uncompression */
> >>  	if (iphc0 & LOWPAN_IPHC_NH_C) {
> >>  		struct udphdr uh;
> >>-		struct sk_buff *new;
> >>  		if (uncompress_udp_header(skb, &uh))
> >>  			goto drop;
> >>@@ -468,14 +459,15 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> >>  		/* replace the compressed UDP head by the uncompressed UDP
> >>  		 * header
> >>  		 */
> >>-		new = skb_copy_expand(skb, sizeof(struct udphdr),
> >>-				      skb_tailroom(skb), GFP_ATOMIC);
> >>-		kfree_skb(skb);
> >>-
> >>-		if (!new)
> >>-			return -ENOMEM;
> >>-
> >>-		skb = new;
> >>+		if (skb_headroom(skb) < sizeof(struct udphdr) + sizeof(hdr)) {
> >>+			int n = sizeof(struct udphdr) + sizeof(hdr);
> >>+
> >>+			err = pskb_expand_head(skb, n, 0, GFP_ATOMIC);
> >replace n with constant value "sizeof(struct udphdr) + sizeof(hdr)".
> ok, I was only trying to make the code more readable here instead of having
> the calculation split over 2 lines.  Actually what is the coding style for
> this case? or could I use a #define and then I could use it in the if
> statement above and well as the pskb_expand_head?

What I see here is that the code describes "putting int n on the stack
and init with compile time calculated value "sizeof(struct udphdr) +
sizeof(hdr)"".

The point is more for me "put it on the stack", I don't know compiler
optimizations much. Maybe it depends on "-O #" if the compiler optimize
here or not. Maybe it also depends on "const int" and "int".

You could do a define at begin of iphc.c (it's not used outside of this
function). I don't see any codestyle issue, only issue what the compiler
generates here. Make whatever you want, but please don't do this on the
stack, I don't see that we touching this afterwards again.

Maybe do it const, that would help the compiler to optimize the code
like to have "sizeof(struct udphdr) + sizeof(hdr)" direct as parameter.

> >>+			if (unlikely(err)) {
> >>+				kfree_skb(skb);
> >>+				return err;
> >>+			}
> >>+		}
> >>  		skb_push(skb, sizeof(struct udphdr));
> >>  		skb_reset_transport_header(skb);
> >>@@ -485,6 +477,15 @@ int lowpan_process_data(struct sk_buff *skb, struct net_device *dev,
> >>  			       (u8 *)&uh, sizeof(uh));
> >>  		hdr.nexthdr = UIP_PROTO_UDP;
> >>+	} else {
> >>+		if (skb_headroom(skb) < sizeof(hdr)) {
> >>+			err = pskb_expand_head(skb, sizeof(hdr), 0, GFP_ATOMIC);
> >>+
> >remove whitespace
> ok
> >>+			if (unlikely(err)) {
> >>+				kfree_skb(skb);
> >>+				return err;
> >>+			}
> >>+		}
> >>  	}
> >>  	hdr.payload_len = htons(skb->len);
> >>diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> >>index c2e0d14..ab51e16 100644
> >>--- a/net/bluetooth/6lowpan.c
> >>+++ b/net/bluetooth/6lowpan.c
> >>@@ -343,13 +343,24 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
> >>  		kfree_skb(local_skb);
> >>  		kfree_skb(skb);
> >>  	} else {
> >>+		/* Decompression may use pskb_expand_head, ensure skb unique */
> >>+		if (skb_cloned(skb)) {
> >marker
> >
> >>+			struct sk_buff *new;
> >>+			int new_headroom = sizeof(struct ipv6hdr) +
> >>+					   sizeof(struct udphdr);
> >>+
> >>+			new = skb_copy_expand(skb, new_headroom,
> >>+					      skb_tailroom(skb), GFP_ATOMIC);
> >>+			if (!new)
> >>+				goto drop;
> >>+			consume_skb(skb);
> >>+			skb = new;
> >>+		}
> >>+
> >>  		switch (skb->data[0] & 0xe0) {
> >>  		case LOWPAN_DISPATCH_IPHC:	/* ipv6 datagram */
> >>-			local_skb = skb_clone(skb, GFP_ATOMIC);
> >>-			if (!local_skb)
> >>-				goto drop;
> >>-			ret = process_data(local_skb, dev, chan);
> >>+			ret = process_data(skb, dev, chan);
> >>  			if (ret != NET_RX_SUCCESS)
> >>  				goto drop;
> >>diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
> >>index c7e07b8..2ccea84 100644
> >>--- a/net/ieee802154/6lowpan_rtnl.c
> >>+++ b/net/ieee802154/6lowpan_rtnl.c
> >>@@ -537,6 +537,19 @@ static int lowpan_rcv(struct sk_buff *skb, struct net_device *dev,
> >>  		if (ret == NET_RX_DROP)
> >>  			goto drop;
> >>  	} else {
> >>+		/* Decompression may use pskb_expand_head, ensure skb unique */
> >>+		if (skb_cloned(skb)) {
> >At this point:
> >
> >First:
> >
> >this SHOULD be always true in this function, but it doesn't. This is a
> >complicated issue inside of mac802154. I will ack this, but for the
> >rework we need to remove this again. Means: Currently I am fine with
> >this change.
> That's the intention, once you're rework is in place this can be removed.

ok.

> >We _should_ do it inside the deliver function  for multiple interface,
> >normally we need something like this at mac802154 layer [0]. It's simple
> >complete broken at current mac802154 mainline state. We set the skb->dev
> >for only one skb struct and we need to clone it before for each interface...
> >then we can touch skb->dev again. So multiple interface is... better not use
> >that. :-)
> >
> >Funny at monitor rx function somebody implement a skb_clone before.
> >
> >
> >Second:
> >
> >I don't know why this is here, before evaluate the dispatch. If we
> >receive LOWPAN_DISPATCH_FRAGN we don't need headroom for ipv6hdr/udphdr.
> >
> >I think we only need this headroom for uncompression and this is for the
> >LOWPAN_DISPATCH_IPHC case. But above, see "marker" you do the same
> >thing again. I mean here we always add room for sizeof(struct ipv6hdr)
> >+ sizeof(struct udphdr), doesn't matter if next header compression is set.
> >
> >And above at "marker" we do the same thing. Also do here always a ... +
> >sizeof(struct udphdr) doesn't fit together with the comming next header
> >compression framework, which needs to evaluate the nhc id to get the
> >right next header size which is necessary for the headroom.
> >
> >I can only imaging why you doing this here, because it is necessary for
> >doing the FRAG1 uncompression on the fly stuff, maybe this is some reason
> >why this is here. But it's not necessary for FRAGN.
> As it's temporary code is it ok to leave it?

Can you explain why we need such function here?

I am not sure about this, but I will trust you here. So leave it when it
doesn't break anything.

> >>+			struct sk_buff *new;
> >>+			int new_headroom = sizeof(struct ipv6hdr) +
> >>+					   sizeof(struct udphdr);

here is the same issue like above "put it on the stack", make it const or
create a define.

- Alex
