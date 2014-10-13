Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45127 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136AbaJMJlF (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Oct 2014 05:41:05 -0400
Date: Mon, 13 Oct 2014 11:41:00 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v5 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141013094058.GB20544@omega>
References: <1412840794-17283-1-git-send-email-martin.townsend@xsilon.com>
 <1412840794-17283-2-git-send-email-martin.townsend@xsilon.com>
 <20141011073620.GA28500@omega>
 <543B90FA.2060603@xsilon.com>
 <20141013085538.GA20544@omega>
 <543B9B4C.1010303@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <543B9B4C.1010303@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: Martin Townsend <mtownsend1973@gmail.com>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com

On Mon, Oct 13, 2014 at 10:28:44AM +0100, Martin Townsend wrote:
...
> >> If it's ok with everyone I'll change pskb_expand_head to skb_cow or skb_cow_head and leave the bluetooth code as it is with this v5 patch.
> > For me it's confusing, you do that on skb, but we never used skb
> > afterwards (maybe on freeing) but we use local_skb, the local_skb should
> > always be cloned because we running skb_clone before.
> skb_clone does ensure that the skb isn't shared anymore so I think it will be safe to remove the skb_share_check.  Or I can move it to the start of the function like we do for 802.15.4?

We need to clarify the following points:

skb_is_shared:

It's used twice in some packet handler functions or elsewhere.

now a skb_clone:

A skb clone is only a copy of struct sk_buff, so we can safely run
skb_pull and skb_push, skb->dev = foo. Simple for modify skb attributes.

now a skb_copy:

It's a complete private copy with private data buffer which allow us to
make skb->data[#] = foobar;



Now skb_share_check do:

if skb_is_shared true, then make a clone. This doesn't allow to
manipulate the data, but skb_cow make a copy of the private data so this
is okay for IPHC call. Means after skb_cow, we have something like
skb_copy, but skb_cow should be faster. ;-)

Also skb_share_check checks if skb_is_shared is false, then we don't
need a skb_clone, because it's not shared, then we are allow to
manipulate skb attributes, because nobody else use it.



I would add skb_share_check at beginning of this function like 802.15.4
but the IPV6 DISPATCH of bluetooth do a complete copy of the data buffer
which seems not necessary, but this is another issue and maybe I think
that the IPV6 DISPATCH value isn't needed by bluetooth 6lowpan. <-- But I
am not sure about this. I also can't see that bluetooth 6lowpan runs
skb_pull for the one byte dispatch value. Jukka need to check that, if
he has time and feel like to doing it.

- Alex
