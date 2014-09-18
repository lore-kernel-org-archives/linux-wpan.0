Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:48938 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769AbaIRJld (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 18 Sep 2014 05:41:33 -0400
Received: by mail-wi0-f173.google.com with SMTP id em10so2738004wid.0
        for <linux-wpan@vger.kernel.org>; Thu, 18 Sep 2014 02:41:31 -0700 (PDT)
Date: Thu, 18 Sep 2014 11:41:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: Promiscuous patches
Message-ID: <20140918094123.GA4350@omega>
References: <5412F199.7010803@xsilon.com>
 <20140914234551.GA7009@omega>
 <541A9E65.3090300@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <541A9E65.3090300@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Sep 18, 2014 at 09:57:09AM +0100, Martin Townsend wrote:
> Hi Alex,
> 
> Thanks for the links, I needed this to get wireshark working again as we now have address filtering support in HW.
> 
> The code looks good and using the net device op for detecting a rx flag change looks good to me.  A couple of thoughts.
> 1) Maybe you could remove the HW flag for promiscuous? just let the driver implement the set_promiscuous_mode driver ops function if the HW supports it or leave it NULL if it doesn't

yea, I had some issue with that. The issue was at86rf212 and at86rf23x
use the same driver, the at86rf230.

The ieee802154_ops should be const (it's already const in the rework
branch). During runtime changes on this makes very very big problems.
Now the ieee802154_ops contains a callback for example listen before receive
".set_lbt". This functionality is only supported for at86rf212 not for
at86rf23x chips. I see no other solution to introduce flags which could
be change during runtime, to indicate that the chip supports this.

A other solution would be to check on chip revision and then "return
-EOPNOTSUPP;", this occurs also in another issue. From userspace you
need to know what the device supports. In this case if you want to know
what the device support's you need to run the driver ops and check if it
was -EOPNOTSUPP, otherwise you did a change into/out of promiscuous
mode. :-)

So replace .set_lbt with .set_promiscuous_mode (maybe I should remove
the "_mode") then we could run into same issues.

I add a check on NULL when calling "drv_set_promiscuous_mode", then this
is bug in driver layer. You setted the flag but not implement the driver
callback. -> this should never occur on a good driver.



btw.

I will add a check on creating monitor interfaces on promiscuous flag.
Simple if a driver doesn't support promiscuous flag, then a monitor
makes no sense.

> 2) I had to implement the ndo_change_rx_flags net device ops in wpan.c not monitor.c.  For remote wireshark captures that we do we use tcpdump -i wpan0 on the boards.  Are we doing something wrong here? Your code seems to suggest that we should bring up a separate monitor interface?
> 

not separate.

You have only one phy. The phy have some mac functionality like address
filter and promiscuous mode. If you go into the promiscuous mode you
disable all filtering blabla on the phy. You know what the promiscuous
does.

But you have only one phy, you can't use address filtering and
promiscuous at the same time. You could do a context switch for all the
registers, but this would not be practical. I hope we have the same
opinion here.

So the interfaces would be:

MONITOR -> enables promiscuous mode, no filtering by FCS(doesn't work
	   yet) addresses, etc... all frames on channel came in.

NODE -> address filtering (if supported), all filtering which is
	practical for common use and which belongs to us.

COORD -> like NODE but with address filtering functionality to run as
         pan coordinator.

These are the mac functionality for phy settings only! We also always
know the current interface type by doing internal linux mac802154 stuff
and that's good for handling mlme ops (managment layer). Very different
when running as NODE or COORD. You know NODE associates with COORDS and
channel scan etc...


Now to your question:

A node or wpan device uses address filtering, but we have also address
filter inside of mac802154, to be sure. So there are two address
filtering running, one of phy mac handling and one inside of mac802154.
The phy mac handling address filter makes sense, because it is really
fast.

In promiscuous mode, the phy interrupts on any frame which is received,
you don't have any address filtering mac functionality on the phy
anymore. That means you have only the linux mac802154 address filtering
functionality running. That means the phy doesn't filter anymore and you
get really all frames and the internal mac802154 filter drops the
packets.

To enable promiscuous mode on a wpan/node type makes no sense. To enables
promiscuous mode on MONITOR makes, sense. On  MONITOR type we don't run
any mac802154 address filtering and you will get any frame on the
monitor interface.


I hope it's understandable what I mean here a little bit.

-Alex

[0] https://github.com/linux-wpan/linux-wpan-next/blob/wpan_rework_rfc/net/mac802154/driver-ops.h#L212
