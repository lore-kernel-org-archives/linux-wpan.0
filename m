Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:62394 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbaISM5K (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Sep 2014 08:57:10 -0400
Received: by mail-we0-f175.google.com with SMTP id w61so2448257wes.34
        for <linux-wpan@vger.kernel.org>; Fri, 19 Sep 2014 05:57:08 -0700 (PDT)
Date: Fri, 19 Sep 2014 14:57:06 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: 6lowpan raw socket problems
Message-ID: <20140919125705.GB2500@omega>
References: <541AE5E9.3000407@xsilon.com>
 <20140918141911.GA9262@omega>
 <20140919110854.GA21364@omega>
 <541C133A.7010000@xsilon.com>
 <20140919114549.GA22396@omega>
 <541C1AC2.1010308@xsilon.com>
 <20140919120630.GA23106@omega>
 <20140919123824.GA2407@omega>
 <541C2536.5080308@xsilon.com>
 <20140919125544.GA2500@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140919125544.GA2500@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, werner@almesberger.net

On Fri, Sep 19, 2014 at 02:55:44PM +0200, Alexander Aring wrote:
> Hi Simon,
> 
> On Fri, Sep 19, 2014 at 01:44:38PM +0100, Simon Vincent wrote:
> ...
> > >mhh, take a look on skb_unshare - make a copy of a shared buffe [0].
> > >
> > >Seems that we could use that to have a copy of the buffer. Don't know if
> > >this can work, because we are inside of callback and the caller lost the
> > >reference then.
> > I tried that earlier! Didn't work as we lost the reference as you say.
> > I think if we do it inside lowpan_xmit like you do in your rework we might
> > be ok. I will have a go.
> > 
> 
> Yea, with combination of lowpan_xmit and do a:
> 
> skb = skb_unshare(skb, GFP_ATOMIC);
> 
> it's woooorrkkinnnnggg.
> 

I hope it's working now, it doesn't look like garbage anymore.

- Alex
