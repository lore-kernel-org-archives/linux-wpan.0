Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from photon.sigxcpu.org ([95.142.169.183]:54638 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbbDTSg3 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 20 Apr 2015 14:36:29 -0400
Date: Mon, 20 Apr 2015 20:35:55 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH] ieee802154: Add trace events for rdev->ops
Message-ID: <20150420183555.GA5248@bogon.m.sigxcpu.org>
References: <20150412120733.GA6181@bogon.m.sigxcpu.org>
 <5530F366.4030407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5530F366.4030407@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

On Fri, Apr 17, 2015 at 05:19:58PM +0530, Varka Bhadram wrote:
> On 04/12/2015 05:37 PM, Guido Günther wrote:
> > This is based on the rdev->ops tracing code from net/wireless/.
> 
> Instead of writing the above commit message its better to write
> what exactly this code is for and how can we use this from
> the user space (if possible with commands).

Adjusted in v2.

> 
> If you want to write your above commit message put it in trace.c/h file 
> 
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > ---
> >  net/ieee802154/Makefile   |   4 +-
> >  net/ieee802154/rdev-ops.h |  77 ++++++++++++---
> >  net/ieee802154/trace.c    |   7 ++
> >  net/ieee802154/trace.h    | 243 ++++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 319 insertions(+), 12 deletions(-)
> >  create mode 100644 net/ieee802154/trace.c
> >  create mode 100644 net/ieee802154/trace.h
> >
> > diff --git a/net/ieee802154/Makefile b/net/ieee802154/Makefile
> > index 05dab29..4adfd4d 100644
> > --- a/net/ieee802154/Makefile
> > +++ b/net/ieee802154/Makefile
> > @@ -3,7 +3,9 @@ obj-$(CONFIG_IEEE802154_SOCKET) += ieee802154_socket.o
> >  obj-y += 6lowpan/
> >  
> >  ieee802154-y := netlink.o nl-mac.o nl-phy.o nl_policy.o core.o \
> > -                header_ops.o sysfs.o nl802154.o
> > +                header_ops.o sysfs.o nl802154.o trace.o
> >  ieee802154_socket-y := socket.o
> >  
> > +CFLAGS_trace.o := -I$(src)
> 
> What is this for..? 

So trace.h is found due to the ftrace magic. See
samples/trace_events/Makefile.

Cheers,
 -- Guido
