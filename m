Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:64331 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaIUHbj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 21 Sep 2014 03:31:39 -0400
Received: by mail-wg0-f43.google.com with SMTP id y10so1482569wgg.2
        for <linux-wpan@vger.kernel.org>; Sun, 21 Sep 2014 00:31:38 -0700 (PDT)
Date: Sun, 21 Sep 2014 09:31:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH linux-wpan] 6lowpan: ensure header compression does not
 corrupt ipv6 header
Message-ID: <20140921073131.GA6551@omega>
References: <1411141362-12614-1-git-send-email-simon.vincent@xsilon.com>
 <9ABADC32-3A37-403D-8482-6158F91F3117@holtmann.org>
 <20140920192653.GA4386@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140920192653.GA4386@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Simon Vincent <simon.vincent@xsilon.com>, linux-wpan@vger.kernel.org, jukka.rissanen@linux.intel.com

On Sat, Sep 20, 2014 at 09:26:53PM +0200, Alexander Aring wrote:
...
> > > +	/* We must take a copy of the skb before we modify/replace the ipv6
> > > +	 * header as the header could be used elsewhere
> > > +	 */
> > > +	skb = skb_unshare(skb, GFP_KERNEL);
> > > +
> 
> need to be GFP_ATOMIC, xmit callback has atomic context.

also check on return value here.

- Alex
