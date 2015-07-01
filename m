Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36467 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798AbbGAQW7 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jul 2015 12:22:59 -0400
Date: Wed, 1 Jul 2015 18:22:52 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH] 6lowpan: Fix extraction of flow label field
Message-ID: <20150701162251.GA9015@omega>
References: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1435659892-22503-1-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: jukka.rissanen@linux.intel.com, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>

Hi,

On Tue, Jun 30, 2015 at 03:24:52AM -0700, Lukasz Duda wrote:
...
> ---
>  net/6lowpan/iphc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
> index 9055d7b..74e56d7 100644
> --- a/net/6lowpan/iphc.c
> +++ b/net/6lowpan/iphc.c
> @@ -284,7 +284,7 @@ lowpan_header_decompress(struct sk_buff *skb, struct net_device *dev,
>  		if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)))
>  			return -EINVAL;
>  
> -		hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
> +		hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);
>  		memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);
>  		skb_pull(skb, 2);

Additional note what I see in this code segment. We don't check if we
_can_ pull from the skb. We should here use lowpan_fetch_skb and check
for error like above instead of memcpy and skb_pull.

Maybe simple do the following:

if (lowpan_fetch_skb(skb, &tmp, sizeof(tmp)) ||
    lowpan_fetch_skb(skb, &hdr.flow_lbl[1], 2)
	return -EINVAL;

hdr.flow_lbl[0] = (skb->data[0] & 0x0F) | ((tmp >> 2) & 0x30);
hdr.flow_lbl[0] = (tmp & 0x0F) | ((tmp >> 2) & 0x30);


The issue is that we don't look at:

memcpy(&hdr.flow_lbl[1], &skb->data[0], 2);

if &skb->data[0] data has room of 2 bytes to read from it.

In case of 802.15.4 6LoWPAN, some drivers allocs the exact len value of
the frame (which is even a bad behaviour, they should alloc the MTU
size), somebody could send a 802.15.4 6LoWPAN packet and the frame
looks _at_ _first_ like a 6LoWPAN frame but the lengths field was too
small that an 6LoWPAN frame with this inline data fits in. Means
somebody generated a 6LoWPAN frame that the behaviour occurs to read out
of buffer of skb->data[0].

A good 6LoWPAN stack should not send such frames, but it is possible for
everybody to send something like that which ends in this bad
behaviour in our side.

In case of bluetooth: I have no idea, how skb room is allocated in
bluetooth.


To be sure we need to check if the &skb->data[0] has the buffer length
before to read the amount of bytes (in this case: 2). This is what
lowpan_fetch_skb does by calling the "pskb_may_pull" function before.

-> So I am really not happy about the current solution about this
function. I hope it was understandable what I think we need to do in
this code segment that the stack is more robust to something like that.

I did never touch the flow_lbl code, but I already changed the most code
that we use lowpan_fetch_skb, but there are still some lacks like in this
case. Would be very happy if somebody sends patches for this and should
be part of the cleanup of flow_lbl compression/decompression. :-/

- Alex
