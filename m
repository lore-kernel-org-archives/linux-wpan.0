Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:39288 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaJVK2h (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 22 Oct 2014 06:28:37 -0400
Received: by mail-wi0-f182.google.com with SMTP id bs8so914212wib.9
        for <linux-wpan@vger.kernel.org>; Wed, 22 Oct 2014 03:28:35 -0700 (PDT)
Date: Wed, 22 Oct 2014 12:52:04 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Questions about the Zigbee in Linux
Message-ID: <20141022105203.GB10402@x61s.guest.pengutronix.de>
References: <EBA0C22CC7D5724C87D7C17A60FEE9EE46D85E@SHSMSX101.ccr.corp.intel.com>
 <20141022082919.GA1603@x61s.guest.pengutronix.de>
 <CAFUtXGw=Nb=bB5rWLDyK++KO55VRCqP6FqonWV2idpUR6si_jQ@mail.gmail.com>
 <20141022103516.GA10402@x61s.guest.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141022103516.GA10402@x61s.guest.pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Maciej Wasilak <wasilak@gmail.com>
Cc: "Zhang, Baoli" <baoli.zhang@intel.com>, "linux-zigbee-devel@lists.sourceforge.net" <linux-zigbee-devel@lists.sourceforge.net>, linux-wpan@vger.kernel.org

On Wed, Oct 22, 2014 at 12:35:16PM +0200, Alexander Aring wrote:
> Hi,
> 
> On Wed, Oct 22, 2014 at 12:00:56PM +0200, Maciej Wasilak wrote:
> > Hi,
> > 
> > 2014-10-22 10:29 GMT+02:00 Alexander Aring <alex.aring@gmail.com>:
> > 
> > >
> > > Little how to is available at [3], this is the old linux-zigbee trac
> > >
> > 
> > There is a very decent howto for RaspberryPi at [0], however it is based on
> > net-next branch. linux-wpan contributes in some organized way to net-next,
> > right?
> 

I need to say that the net-next is the old behaviour. The old one when
the 802.15.4/6LoWPAN branch wasn't much maintained anymore.

Up-to-date implementation should be linux-wpan-next or
linux-bluetooth-next.

- Alex
