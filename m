Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:50920 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfDCGX5 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 3 Apr 2019 02:23:57 -0400
Message-ID: <50a114ab56ec46ab88f7721081e1d1489fe0f369.camel@linux.intel.com>
Subject: Re: [PATCH net] 6lowpan: Off by one handling ->nexthdr
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Wed, 03 Apr 2019 09:23:52 +0300
In-Reply-To: <20190403053416.GA21913@kadam>
References: <20190403053416.GA21913@kadam>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>, Alexander Aring <alex.aring@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

On Wed, 2019-04-03 at 08:34 +0300, Dan Carpenter wrote:
> NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
> "hdr->nexthdr" from the network and then look it up in
> lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff
> then
> we read one element beyond the end of the array so the array needs to
> be one element larger.
> 
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is the only place which uses the NEXTHDR_MAX define, so I
> considered
> changing that to 256 instead.  Either fix would work.
> 
>  net/6lowpan/nhc.c  | 2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> index 4fa2fdda174d..9e56fb98f33c 100644
> --- a/net/6lowpan/nhc.c
> +++ b/net/6lowpan/nhc.c
> @@ -18,7 +18,7 @@
>  #include "nhc.h"
>  
>  static struct rb_root rb_root = RB_ROOT;
> -static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX];
> +static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
>  static DEFINE_SPINLOCK(lowpan_nhc_lock);
>  
>  static int lowpan_nhc_insert(struct lowpan_nhc *nhc)

Nice catch!

Acked-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka
