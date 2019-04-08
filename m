Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io1-f66.google.com ([209.85.166.66]:42889 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDHSQV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 8 Apr 2019 14:16:21 -0400
Received: by mail-io1-f66.google.com with SMTP id c4so11870324ioh.9
        for <linux-wpan@vger.kernel.org>; Mon, 08 Apr 2019 11:16:21 -0700 (PDT)
Date: Mon, 8 Apr 2019 14:16:18 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH net] 6lowpan: Off by one handling ->nexthdr
Message-ID: <20190408181618.2m5c3aqlqjmem57j@x220t>
References: <20190403053416.GA21913@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190403053416.GA21913@kadam>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi,

On Wed, Apr 03, 2019 at 08:34:16AM +0300, Dan Carpenter wrote:
> NEXTHDR_MAX is 255.  What happens here is that we take a u8 value
> "hdr->nexthdr" from the network and then look it up in
> lowpan_nexthdr_nhcs[].  The problem is that if hdr->nexthdr is 0xff then
> we read one element beyond the end of the array so the array needs to
> be one element larger.
> 
> Fixes: 92aa7c65d295 ("6lowpan: add generic nhc layer interface")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Alexander Aring <aring@mojatatu.com>

Thanks.

- Alex
