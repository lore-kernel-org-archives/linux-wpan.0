Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:56348 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbaKDObv (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 09:31:51 -0500
Date: Tue, 4 Nov 2014 15:31:46 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: fix udp header
 compression when using raw skts
Message-ID: <20141104143144.GD643@omega>
References: <1415108633-32358-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1415108633-32358-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi Simon,

there is a typo in the subject s/skts/skbs/

Also remove the 'ieee802154:" tag. Just "6lowpan:" here, because this is
a patch for the generic 6lowpan branch.

On Tue, Nov 04, 2014 at 01:43:53PM +0000, Simon Vincent wrote:
> If you use RAW sockets the transport header offset is not set by the
> ipv6 stack so when we get to the udp header compression it does not
> compress the right part of the packet.
> 
> This patch adds a check for this scenario and sets the transport
> header offset.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
> ---
>  net/6lowpan/iphc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 73a7065..305bf2b 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -512,9 +512,17 @@ static u8 lowpan_compress_addr_64(u8 **hc_ptr, u8 shift,
>  
>  static void compress_udp_header(u8 **hc_ptr, struct sk_buff *skb)
>  {
> -	struct udphdr *uh = udp_hdr(skb);
> +	struct udphdr *uh;
>  	u8 tmp;
>  
> +	/* In the case of RAW sockets the transport header is not set by
> +	* the ip6 stack so we must set it ourselves
> +	*/

There are missing spaces. '*' should be in the same line position.

> +	if (skb->transport_header == skb->network_header)
> +		skb_set_transport_header(skb, sizeof(struct ipv6hdr));
> +

okay, this should set on every next header compression. We have
currently UDP only. For the next header compression layer we should move
this handling somewhere else where it always checks on this.
Nevertheless this solution is okay for now.


The next header compression mainline patches:

When I will find some time or somebody else can send it mainline and grab the
base code from [0]. I would be very happy if somebody can do this work
for me. I am working on the 802.15.4 subsystem currently. Isn't perfect
right now and there was also some review notes.

So if anybody wants to do that, please raise your hand.

> +	uh = udp_hdr(skb);
> +
>  	if (((ntohs(uh->source) & LOWPAN_NHC_UDP_4BIT_MASK) ==
>  	     LOWPAN_NHC_UDP_4BIT_PORT) &&
>  	    ((ntohs(uh->dest) & LOWPAN_NHC_UDP_4BIT_MASK) ==

- Alex

[0] https://github.com/linux-wpan/linux-wpan-next/commits/nhc_layer
