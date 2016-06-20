Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:19865 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752789AbcFTHJR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 20 Jun 2016 03:09:17 -0400
Message-ID: <1466406443.31678.121.camel@linux.intel.com>
Subject: Re: current btle 6lowpan issues
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 20 Jun 2016 10:07:23 +0300
In-Reply-To: <594d0734-87d2-2cbf-716b-2c3b0ac97ac6@pengutronix.de>
References: <ccd6b822-4af0-ea89-2dba-b914e6427191@pengutronix.de>
	 <1466071258.31678.12.camel@linux.intel.com>
	 <1466084491.13892.99.camel@linux.intel.com>
	 <594d0734-87d2-2cbf-716b-2c3b0ac97ac6@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, Patrik Flykt <Patrik.Flykt@linux.intel.com>, Linux Bluetooth <linux-bluetooth@vger.kernel.org>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

On Thu, 2016-06-16 at 23:38 +0200, Alexander Aring wrote:
> Hi,
> 
> On 06/16/2016 03:41 PM, Patrik Flykt wrote:
> > 
> > On Thu, 2016-06-16 at 13:00 +0300, Jukka Rissanen wrote:
> > > 
> > > Yes you are right that there are issues. Fortunately the bt0 is
> > > currently a point-to-point link in which case ND is not really
> > > done
> > > and everything kind of "works" ok.
> > > 
> > > I added Patrik to cc: as he has been working to fix the issues
> > > but
> > > the patches are not yet ready. Perhaps we could combine the
> > > efforts
> > > here.
> > I had some patches that make BTLE interfaces non-point-to-point.
> > Let me
> > check that they can be applied on the latest bluetooth-next and
> > that
> > they still compile after a few months of sitting on an old version.
> > Then let's hope they also work as expected...
> > 
> With non-point-to-point you mean to remove the IFF_POINTOPOINT flag
> in
> net_device? Yes this should be removed.

Yes, agreed.

> 
> But I think this is one of the smallest issue in btle 6lowpan.
> 
> What means "ND is not really done", does that means you will not see
> btle neighbours by doing "ip -6 neigh" for your bt interface?

Yes.

> 
> I don't believe that and I think no matter if you set IFF_POINTOPOINT
> or
> not, the IPv6 stack will mostly ignore such flag. I did a grep and it
> seems the SIT stuff sets this flag and IPv6 stack does something with
> that, but not in case of ARPHRD_6LOWPAN, it's for ARPHRD_SIT only. So
> I
> think this flag makes some "peer" address in "ip a" handling instead
> of
> showing broadcast address. But nobody will make special handling in
> IPv6
> or btle 6lowpan if this flag is set.
> 
> What I mean is, you can set this flag on or off but it will don't
> change
> any behaviour.

Unfortunately there is a different behaviour. If the interface has
IFF_POINTTOPOINT, then kernel will not send neighbor discovery messages
to that link. I have not checked the kernel code where exactly that is
enforced but I have looked the wireshark output and there are no ND's
sent if bt0 is p-to-p link. If the flag is removed, the device starts
to send ND's to that interface.

Removing the IFF_POINTTOPPOINT is not enough as the MAC address will be
wrongly set in that case as you have noticed.


Cheers,
Jukka

