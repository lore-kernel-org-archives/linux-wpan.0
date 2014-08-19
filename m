Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59838 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbaHSQ4p (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Aug 2014 12:56:45 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so5481540wiw.1
        for <linux-wpan@vger.kernel.org>; Tue, 19 Aug 2014 09:56:44 -0700 (PDT)
Date: Tue, 19 Aug 2014 18:56:41 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: mac802154: TX results and ACK processing
Message-ID: <20140819165640.GC1116@omega>
References: <CAJ018wBU9OXQfrVr3x+EoeT0V8CM+s80xcCUvM4Urj-zdtHcsA@mail.gmail.com>
 <20140819152319.GA1116@omega>
 <CAJ018wCNUhoJQvM+bYFGqEui1KLZjHe_X3ieYr_+hVcJXQkffA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ018wCNUhoJQvM+bYFGqEui1KLZjHe_X3ieYr_+hVcJXQkffA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: =?utf-8?B?Sm/Do28=?= Pedro Taveira <joao.p.taveira@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Tue, Aug 19, 2014 at 05:27:43PM +0100, João Pedro Taveira wrote:
> On Tue, Aug 19, 2014 at 4:23 PM, Alexander Aring <alex.aring@gmail.com> wrote:
> >
> > I thought RPL needs the LQI value. For the LQI value I (we) thought about
> > to handle the LQI value like the wireless signal strength.
> RPL doesn't need LQI.It depends on RPL configurations and parameters,
> which metrics it will use. One could setup RPL to use metrics based on
> ETX, LQI, battery voltage, mains, temperature, ... sky is the limit.

ok, we currently doesn't offer any of these information.

> >
> > If you have a wireless card, simple type:
> >
> > "iw dev $WLAN_DEV scan dump" (maybe you need to run a scan first). You will
> > see all access points and their signal strength etc.
> >
> > We should have something similar for all neighbor nodes and LQI values,
> > tx failures and similar information.
> >
> >> What's your opinion?
> >>
> >
> > I think we should get a working mac layer with a working 6LoWPAN layer
> > at first, then we can do effort to implement RPL or RFC6775.
> RPL works on IPv6 layer, it doesn't depend on 6lowpan. I already
> started to implement several RFCs but not MHROF. Right now, I can
> connect linux and contiki sensors using rpl_of_of0, but this is the
> basic. To get mhrof working with default configurations as defined on
> RFCs, ETX should be available. My problem is that RPL works on IPv6
> layer, but ETX it's only available on link layer. Some abstraction
> should be available to allow implementation of RPL metrics and RPL
> Objective functions to make use of any metrics on existing link
> protocols.
> 

Okay, then this is a general question to your implementation. Maybe you
ask this on netdev and not related to 802.15.4/802.15.4 6LoWPAN. It's
more a IPv6 question.

We don't support to offer these information in any case. Maybe you want
to try to implement/test your RPL implementation for 802.11, there you
have more change to access information like this. Maybe in future we
offer these information in mac802154.

- Alex
