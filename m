Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from coyote.holtmann.net ([212.227.132.17]:56404 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfDWRKb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 23 Apr 2019 13:10:31 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH net] 6lowpan: Off by one handling ->nexthdr
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190403053416.GA21913@kadam>
Date: Tue, 23 Apr 2019 19:10:28 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <18F5B032-F127-4EB9-8DB8-F760C6455431@holtmann.org>
References: <20190403053416.GA21913@kadam>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

> NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
> "hdr->nexthdr" from the network and then look it up in
> lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff then
> we read one element beyond the end of the array so the array needs to
> be one element larger.
> 
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is the only place which uses the NEXTHDR_MAX define, so I considered
> changing that to 256 instead.  Either fix would work.
> 
> net/6lowpan/nhc.c  | 2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
