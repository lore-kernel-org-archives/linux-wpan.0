Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:54593 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324AbaIVIXL (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 22 Sep 2014 04:23:11 -0400
Received: by mail-we0-f177.google.com with SMTP id t60so2462519wes.22
        for <linux-wpan@vger.kernel.org>; Mon, 22 Sep 2014 01:23:10 -0700 (PDT)
Date: Mon, 22 Sep 2014 10:23:04 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan] 6lowpan: ensure header compression does not
 corrupt ipv6 header
Message-ID: <20140922082303.GA6279@omega>
References: <1411141362-12614-1-git-send-email-simon.vincent@xsilon.com>
 <9ABADC32-3A37-403D-8482-6158F91F3117@holtmann.org>
 <20140920192653.GA4386@omega>
 <20140921073131.GA6551@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140921073131.GA6551@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

Hi,

On Sun, Sep 21, 2014 at 09:31:31AM +0200, Alexander Aring wrote:
> On Sat, Sep 20, 2014 at 09:26:53PM +0200, Alexander Aring wrote:
> ...
> > > > +	/* We must take a copy of the skb before we modify/replace the ipv6
> > > > +	 * header as the header could be used elsewhere
> > > > +	 */
> > > > +	skb = skb_unshare(skb, GFP_KERNEL);
> > > > +
> > 
> > need to be GFP_ATOMIC, xmit callback has atomic context.
> 
> also check on return value here.

We should also do it like while receiving, see [0].

Only if shared make clone and buffer isn't shared. Do this with
"skb_share_check".

- Alex

[0] http://lxr.free-electrons.com/source/net/ieee802154/6lowpan_rtnl.c#L462
