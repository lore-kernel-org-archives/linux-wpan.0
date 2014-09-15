Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34799 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbaIOMCS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 15 Sep 2014 08:02:18 -0400
Received: by mail-wi0-f177.google.com with SMTP id em10so4058973wid.4
        for <linux-wpan@vger.kernel.org>; Mon, 15 Sep 2014 05:02:09 -0700 (PDT)
Date: Mon, 15 Sep 2014 14:01:59 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140915120158.GA15047@omega>
References: <5412F199.7010803@xsilon.com>
 <20140914234551.GA7009@omega>
 <20140914235607.GB7009@omega>
 <20140915115618.GC13603@omega>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140915115618.GC13603@omega>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Mon, Sep 15, 2014 at 01:56:18PM +0200, Alexander Aring wrote:
> On Mon, Sep 15, 2014 at 01:56:07AM +0200, Alexander Aring wrote:
> > On Mon, Sep 15, 2014 at 01:45:51AM +0200, Alexander Aring wrote:
> > > Hi Martin,
> > > 
> > > On Fri, Sep 12, 2014 at 02:14:01PM +0100, Martin Townsend wrote:
> > > > Hi Alex,
> > > > 
> > > > You sent me a patch not long ago to allow automatic setting of promiscous mode.  I seem to have lost this patch, could you resend as I want to look into it.
> > > > 
> > > 
> > > some of my old branch [0].
> > > 
> > > btw.
> > > 
> > > I added to the rework now the promiscous mode and decided to not enable
> > > this mode while setting promiscous mode flag.
> > > 
> > > It's now setted by doing a ifup of a monitor interface. See [1].
> > > 
> > > Maybe you will change it like this (it's better) but there are so many
> > > issue to think about (Disable promiscous if netif on non MONITOR
> > > interfaces etc...).
> > > 
> > > And also you can't have NODE and MONITOR running because it's phy mac
> > > sublayer attribute.
> > > 
> > 
> > I mean with mac sublayer here, some timing critical mac operations/algorithmn
> > done by phy's. Like AACK/ARET, CSMA, etc handling. I don't beleieve that we can
> > ever handle these timing ciriticals inside mac802154.
> > 
> > So we have multiple interfaces but one phy. :-)
> > 
> > One phy means we need to check the constraints that these parameters are
> > always the same on each interface.
> > 
> > On phy pib handling we don't need that. This is no MAC algorithmn, it's
> > only physical changes to the phy rf handling and for the rework we don't
> > have the multiple phy handling anymore.
> > 
> 
> grml s/promiscous/promiscuous everywhere. I need to remember that.
> Sorry.
> 
> I will fix it on the branch.
> 

Seems to be a common error, "grep -r promiscous .":

./drivers/net/ethernet/wiznet/w5100.c:#define   S0_MR_MACRAW		  0x04 /* MAC RAW mode (promiscous) */
./drivers/net/ethernet/wiznet/w5300.c:#define   S0_MR_MACRAW		  0x0004  /* MAC RAW mode (promiscous) */
./drivers/net/wireless/ath/ath10k/htt.h:	/* Non-data in promiscous mode */

- Alex
