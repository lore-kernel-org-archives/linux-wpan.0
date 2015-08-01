Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38413 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbbHAIqC (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Aug 2015 04:46:02 -0400
Received: by wibxm9 with SMTP id xm9so57728600wib.1
        for <linux-wpan@vger.kernel.org>; Sat, 01 Aug 2015 01:46:01 -0700 (PDT)
Date: Sat, 1 Aug 2015 10:46:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 1/2] ieee802154: 6lowpan: remove
 multiple lowpan support
Message-ID: <20150801084617.GA759@omega>
References: <1438341102-15878-1-git-send-email-alex.aring@gmail.com>
 <1438341102-15878-2-git-send-email-alex.aring@gmail.com>
 <4122.1438389297@sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4122.1438389297@sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

On Fri, Jul 31, 2015 at 08:34:57PM -0400, Michael Richardson wrote:
> 
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > We currently supports multiple lowpan interfaces per wpan interface. I
>     > never saw any use case into such functionality. We drop this feature
> 
> I was confused at first, because I was sure that you didn't mean that we
> would not have support for multiple radios.
> 

What we have is:

 - wpan_phy - which represents the transceiver, which contains phy
   settings (channel/cca/page, usually known as pib, also some phy
   depended mac settings). This is in linux a device class.

 - wpan_dev - which represents the mac layer of 802.15.4 and contains
   the mib. Now it comes a little bit complicated because phy's
   (real transceivers) supports some mac functionality like address
   filtering, time critical things (aret,csma,etc.)
   These settings do we set on interface up in phy registers and currently
   not changeable while interface is up.

 - lowpan_dev - the lowpan interface which do the 6LoWPAN adaption layer
   on a wpan_dev.

Currently we have such architecture about handling multiple interfaces:

 - ONE phy
 - on each phy we can setup multiple wpan interfaces, this depends on
   the mac settings which is supported by phy.
   e.g. All node interfaces need to have the same address when the phy
   supports address-filtering, because we can setup one address filter
   only.
 - on each wpan interface you can have multiple lowpan interfaces.

I tried to draw some graphic about this situation:

                phy0                          phy1
	       / | \                          ....
              /  |  \
         wpan0 wpan1 wpan#
        /  \        \     \_____
       /    \        \        \\\
   lowpan01 lowpan01 lowpan10 lowpan##


For wpan interfaces the use case "could be", that you can change the mib
fast by having one wpan interface up and other down. MIB context
switching is down one interface, then up another interface.

This is the one usecase which I can see for wpan interfaces, but this
mechanism can also be done by userspace which handles the MIB in some
context table.

We have such support because "historical" reasons, I can do some
assumptions only why we have it. In my opinion it's because many code is
grabbed (also before I started) from wireless subsystem and they have
the use case because some phys supports multiple access points handling
and such things.

Nevertheless we don't talking here about now for the multiple wpan
interface feature. We talking about the multiple lowpan interface which
makes no sense for me. In linux you would have then some multiple lowpan
interfaces (maybe with different _IPv6_ addresses) which belongs to one
wpan interface. I never used such feature. Also I think when two lowpan
interface (which uses the same L2 addresses) will occur that the ndisc
cache at receiving nodes will get confused, because two IPv6 stacks on
one wpan interface with the same L2 addresses will operate then. (Maybe
you will also get some duplicate address detection, because the SLAAC address
(I mean the fe80::EUI64_WITH_BITFLIP/64) is the same on both interfaces).

Again I think why we have such feature currently is because the code was
copy&pasted from ethernet bridge code and there they support (and makes
sense) multiple bridges per ethernet interface.

> What you are saying is that we won't have multiple lowpan adaption layers per
> wpan interface?

yes.

> That does not, I think mean that we can't respond to multiple
> EUI-64 layer-2 addresses, but does it have any affect on ability to respond
> to multiple 16-bit (short) addresses?

On receiving we get frames from extended/short destination which are setup also
at the address filtering on phy setting (inclusive short address broadcast).

Note:

Short addresses are currently not handled by the 802.15.4 6LoWPAN stack
and is another issue where a possible solution for this is _maybe_ there
(will come up in some RFC next days/months). Maybe I should send a draft
for a possible handling of this in the next days.

This is currently another issue for handling short addresses correctly,
because we need special runtime decisions inside of ndisc cache for
setting the ICMPv6 length field and decide if short/extended.

Anyway back to the extended/short in lowpan_dev:

You said "respond", we can respond to any address which we set inside
the mac header. On receiving we can accept only the addresses which are
also set inside the MIB of the wpan interface (inklusive broadcast,
etc.) This all goes into the "address filtering" functionality inside
the phy "mac functionality for address filtering setting".

At the end I would answer your question "but does it have any affect on
ability to respond to multiple 16-bit (short) addresses?" with "no".

Because I don't see no different L2 address handling when we drop the
multiple lowpan interfaces functionality.


Does this answers some questions for you?

- Alex
