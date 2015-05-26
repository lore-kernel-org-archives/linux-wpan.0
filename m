Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33656 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227AbbEZMZf (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 08:25:35 -0400
Received: by wgez8 with SMTP id z8so95588987wge.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 05:25:30 -0700 (PDT)
Date: Tue, 26 May 2015 14:17:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/4] mac802154: fix hold rtnl while ioctl
Message-ID: <20150526121715.GB27844@omega>
References: <1432309434-8215-1-git-send-email-alex.aring@gmail.com>
 <1432309434-8215-2-git-send-email-alex.aring@gmail.com>
 <20150525120940.GA21258@wantstofly.org>
 <F4B0D55C-BCEE-4E58-A89D-7546F6D63724@holtmann.org>
 <20150526073641.GQ11340@wantstofly.org>
 <20150526081506.GA1033@omega>
 <20150526115100.GR11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150526115100.GR11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Tue, May 26, 2015 at 02:51:00PM +0300, Lennert Buytenhek wrote:
> > - Hold the rtnl lock only when the socket code is called. I insert this
> >   code because somebody tried to ioctl a 802.15.4 socket and the lock
> >   wasn't held. Maybe we can hold the rtnl lock in the caller, see [0].
> >   But this requires that all other callers hold the rtnl lock while
> >   calling this callback and I don't know if this is true.
> 
> I think that it makes sense to keep the invariant that upon entry
> of an ioctl, no locks are guaranteed to be held.  WEXT violates this
> principle, but I would say that the WEXT behavior is undesirable, as
> it's not a good thing to take a bunch of locks just in case a callee
> might need them, and it will cause code to be written that will
> (silently) depend on these assumptions and it will be hard to untangle
> those dependencies later on, or even impossible to do in case it
> becomes part of an API/ABI (like it is now in the WEXT case).
> 

ok.

> 
> > Nevertheless your solutions will reduce to hold the rtnl_lock if not
> > necessary and fixes the nm issue. So you get a:
> > 
> > Acked-by: Alexander Aring <alex.aring@gmail.com>
> 
> Cool, I'll do this and submit it.
> 

ok.

> 
> > If you see that to remove the ioctl it's a good idea (okay that's maybe
> > not a good idea because there are at least one user outside which use
> > this feature) you can send a patch for it.
> 
> I agree that this ioctl is an ugly wart, and that it should probably
> be scheduled to be removed entirely.  Do you have visibility into
> what userspace code might be using this -- I know that there's a
> zigbee stack, but I don't think we can see it?

no, I don't know any _real_ software which using this ioctl. There was
maybe a zigbee stack which wasn't released open source but I did not work
on this stuff. I think, the previous maintainers just implement the way what
they need for his userspace stuff, but I never saw any code about that.

Don't know if this is still active in development.


I know the following code which using this code:

 - deprecated lowpan-tools has some unit tests to access this ioctl.

 - the secuirty layer stuff. But this isn't supported by any official
   userspace software currently. There is some outside at [0]. But I
   would prefer to adding support for nl802154 and wpan-tools in some
   way which is very easy to setup.

 - The person which reported the issue with rtnl lock. [1]

- Alex

[0] https://github.com/mysmartgrid/hexabus/tree/pb-crypto
[1] http://www.spinics.net/lists/linux-wpan/msg01893.html
