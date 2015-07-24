Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38324 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbbGXPKR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Jul 2015 11:10:17 -0400
Received: by wibxm9 with SMTP id xm9so32188348wib.1
        for <linux-wpan@vger.kernel.org>; Fri, 24 Jul 2015 08:10:16 -0700 (PDT)
Date: Fri, 24 Jul 2015 17:10:17 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 0/2] ieee802154: multiple lowpan interface
 support and fix mac setting
Message-ID: <20150724150945.GA6594@omega>
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
 <55B25342.3070005@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55B25342.3070005@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, marcel@holtmann.org

On Fri, Jul 24, 2015 at 05:01:22PM +0200, Stefan Schmidt wrote:
> Hello.
> 
> On 24/07/15 15:01, Alexander Aring wrote:
> >Hi,
> >
> >this patch series contains two patches. At first we remove the multiple
> >lowpan interface support. I don't see any use case for that, if somebody
> >has an use case for it. Please report your use case.
> 
> I had to read the commit message to find out that you mean multiple lowpan
> interfaces on one wpan interface here. And not multiple lowpan interface on
> one machine which I thought first. :)
> 

ok, I will remember that. I should say more detailed information, but
yes it's multiple lowpan interface per wpan interface.

I think the reason why we have it is that some parts of the code is
grabbed from the eth bridge rtnl code. And multiple bridges for one
ethernet interface makes sense.

In our case, we don't have any use case, I see no sense to have multiple
lowpan interface.

> The later has for sure enough use cases :)
> 
> I don't have a use case for the former (the one you remove here) either.
> Still we might want to consider this as an RFC here to give folks a moment
> to speak up with they use this.
> 

ok. Keeping this functionaltiy makes things much complicated to deal
with it and I don't know that somebody use this functionaltiy which
makes for me no sense. I thought already 2 years long about to remove
this functionaltiy. :-)


Then to Marcel:

Please don't apply this patch until we can figure out any use case for
such functionaltiy.

> >
> >Currently it's broken to update the wpan mac address while having a lowpan
> >interface on the top. The first patch will introduce some easy mechanism
> >to access the lowpan interface inside the lower mac802154 layer. When the
> >mac802154 changes the mac address then it will updated also on the lowpan
> >interface, if the wpan interface belongs to a lowpan interface.
> 
> Just back from vacation and catching up with to many things. I can give this
> a test on my setup next week if you want.
> 

ok.

- Alex
