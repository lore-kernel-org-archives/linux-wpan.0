Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:37390 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbaJHIGX (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 8 Oct 2014 04:06:23 -0400
Date: Wed, 8 Oct 2014 10:06:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH v3 bluetooth-next] 6lowpan: Use pskb_expand_head in IPHC
 decompression.
Message-ID: <20141008080618.GB32554@omega>
References: <1412753745-6469-1-git-send-email-martin.townsend@xsilon.com>
 <1412753745-6469-2-git-send-email-martin.townsend@xsilon.com>
 <20141008075458.GA32554@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141008075458.GA32554@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, marcel@holtmann.org, jukka.rissanen@linux.intel.com, Martin Townsend <martin.townsend@xsilon.com>

Hi Martin,

On Wed, Oct 08, 2014 at 09:54:58AM +0200, Alexander Aring wrote:
...
> 
> here we lost the skb reference from parameter if failed and I don't see
> that skb_unshare free it on failing (maybe I am wrong here).
> 

I will do this step by step.

1. call skb_unshare

2. check if cloned

3. call skb_copy

4. call __alloc_skb

5. __alloc_skb return NULL

6. assign to temp nskb;

7. parameter skb will be freed. kfree_skb(skb).

8. skb = nskb;

9. return skb;

So I see that kfree_skb(skb) is always called also on failure.

So your code seems to be correct. This is a lack of documentation.

- Alex
