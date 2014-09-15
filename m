Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:47976 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbaIOL4X (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Sep 2014 07:56:23 -0400
Received: by mail-wg0-f52.google.com with SMTP id x13so3694875wgg.11
        for <linux-wpan@vger.kernel.org>; Mon, 15 Sep 2014 04:56:21 -0700 (PDT)
Date: Mon, 15 Sep 2014 13:56:19 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140915115618.GC13603@omega>
References: <5412F199.7010803@xsilon.com>
 <20140914234551.GA7009@omega>
 <20140914235607.GB7009@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140914235607.GB7009@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Mon, Sep 15, 2014 at 01:56:07AM +0200, Alexander Aring wrote:
> On Mon, Sep 15, 2014 at 01:45:51AM +0200, Alexander Aring wrote:
> > Hi Martin,
> > 
> > On Fri, Sep 12, 2014 at 02:14:01PM +0100, Martin Townsend wrote:
> > > Hi Alex,
> > > 
> > > You sent me a patch not long ago to allow automatic setting of promiscous mode.  I seem to have lost this patch, could you resend as I want to look into it.
> > > 
> > 
> > some of my old branch [0].
> > 
> > btw.
> > 
> > I added to the rework now the promiscous mode and decided to not enable
> > this mode while setting promiscous mode flag.
> > 
> > It's now setted by doing a ifup of a monitor interface. See [1].
> > 
> > Maybe you will change it like this (it's better) but there are so many
> > issue to think about (Disable promiscous if netif on non MONITOR
> > interfaces etc...).
> > 
> > And also you can't have NODE and MONITOR running because it's phy mac
> > sublayer attribute.
> > 
> 
> I mean with mac sublayer here, some timing critical mac operations/algorithmn
> done by phy's. Like AACK/ARET, CSMA, etc handling. I don't beleieve that we can
> ever handle these timing ciriticals inside mac802154.
> 
> So we have multiple interfaces but one phy. :-)
> 
> One phy means we need to check the constraints that these parameters are
> always the same on each interface.
> 
> On phy pib handling we don't need that. This is no MAC algorithmn, it's
> only physical changes to the phy rf handling and for the rework we don't
> have the multiple phy handling anymore.
> 

grml s/promiscous/promiscuous everywhere. I need to remember that.
Sorry.

I will fix it on the branch.

- Alex
