Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:49092 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbaJWKHR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Oct 2014 06:07:17 -0400
Date: Thu, 23 Oct 2014 12:30:43 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth-next 0/4] 6lowpan: Move skb delivery out of
 IPHC
Message-ID: <20141023103023.GA12549@x61s.guest.pengutronix.de>
References: <1413967190-28890-1-git-send-email-martin.townsend@xsilon.com>
 <20141023094355.GA11768@x61s.guest.pengutronix.de>
 <5448CFA8.3020604@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5448CFA8.3020604@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

Hi Martin,

On Thu, Oct 23, 2014 at 10:51:36AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> Looks like the SKB is now non-linear which causes the skb_put to assert.  Maybe skb_linearlize will help[0]
> 
> I'll also take a look.

yes, I did also take a fast look at:

"kernel BUG at net/core/skbuff.c:1275!"

But why occurs this now? I think you didn't change anything in this
behaviour in the sequence of skb_put, etc...



I know now why this happens, maybe I can't test it currently fast.

In file net/ieee802154/6lowpan_rtnl.c at function "lowpan_rcv"

case LOWPAN_DISPATCH_FRAG1:     /* first fragment header */
	ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAG1);
	if (ret == 1) {
		ret = iphc_decompress(skb, &hdr);
		if (ret < 0) 
			goto drop;
	}
	break;
case LOWPAN_DISPATCH_FRAGN:     /* next fragments headers */
	ret = lowpan_frag_rcv(skb, LOWPAN_DISPATCH_FRAGN);
	if (ret == 1) {
		ret = iphc_decompress(skb, &hdr);
		if (ret < 0) 
			goto drop;
	}
	break;

later you do _ALWAYS_ a "lowpan_give_skb_to_devices". But you changed
now the behaviour, because in case of LOWPAN_DISPATCH_FRAG1 or
LOWPAN_DISPATCH_FRAGN should lowpan_give_skb_to_devices only called when
lowpan_frag_rcv returns 1 and after iphc_decompress.

I think that's your problem. Always call lowpan_give_skb_to_devices
seems to be 100% wrong.

- Alex
