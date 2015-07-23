Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34889 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbbGWIWp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Jul 2015 04:22:45 -0400
Date: Thu, 23 Jul 2015 10:22:45 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC v2 0/4] Adding stateful compression to IPHC
Message-ID: <20150723082242.GB19536@omega>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jul 13, 2015 at 01:50:29PM +0200, Lukasz Duda wrote:
> Hi all,
> 
> Resending the RFC patch set after some clean up.
> 
> The following patches introduce support for stateful compression in IPHC.
> 
> Patch #1: Introduce debugfs entry for 6lowpan module
> Patch #2: Add stateful compression component of 6lowpan module
> Patch #3: Add stateful compression support for iphc.c
> Patch #4: Enable stateful compression in bluetooth_6lowpan
> 
> Usage of stateful compression is described in Patch #2.
> 
> Notes
> =====
> 
> RFC v2:
>     - Splitting patch into smaller incremental patches
>     - Moving debugfs logic from iphc.c into context.c
>     - Updating patch set to align with style and coding guideline
>     
> RFC v1:
>     - Initial patch set: http://www.spinics.net/lists/linux-bluetooth/msg62930.html
> 
> Limitations
> ===========
> 
> - Temporarly use of debugfs to be able to add context table entries.
> - Current module does not support context time-outs.
> - No support for multicast addresses stateful compression.
> 
> Discussion: Idea on how to make the 6lowpan context tables out of debug mode
> ============================================================================
> 
> The patch provided here is just a temporary solution where the contexts are
> manually added. The proper way of adding/removing contexts would be to make
> ndisc.c parse 6CO options and act upon it. Generated Router Advertisement
> packets with 6CO option (for example from RADVD) will be handled in the
> ndisc_router_discovery function.
> 

I think it's currently fine to bring such functionality over debugfs for
introduce the functionality. If we have it done, then we talk about more
detailed process how to make the dealing with 6CO, ipv6 stack and 6lowpan
module.

> Also, other flags like ARO, ABRO etc. which are specified in RFC6775 need
> to be handled in the ipv6 module in order to do it in a neat way.
> Potentially the RFC6775 extensions could also be used by other protocols
> than BLE and 802.15.4.
> 
> There is a need for parsing the 6CO option in ndisc.c which parses Router
> Advertisement messages. Today the function calls to IPHC (6lowpan module) are
> quite hard to implement in ndisc.c, as there is no guarantee that the 6lowpan
> module will be loaded or not. It would make sense to build 6lowpan module
> as in-build part of IPv6. The features could be compiled in by using #defines.
> 
> What do you think about moving 6lowpan as a component of IPv6 and modify ndisc.c

The initial idea of 6lowpan is to work as adaptation layer. This is exactly
what we try to do with the virtual lowpan interface, doing compression/uncompression
and such stuff before we give the packet to the next layer. 6LoWPAN has also
some differents between btle/802.15.4 e.g. we need to run some fragmentation/reassemble
before ipv6 layer.

To run as adaptation layer this isn't always possible, like in your case
the 6CO field. Also in 802.15.4 we need a special handling for different
mac address types short and extended (which is not supported right now).

I think we should try to handling it still as seperate module so far we
can, if the netdev people says something that we can't do and the
solution would be a move of 6lowpan branch into ipv6, then we should do
it. E.g. Maybe they don't like function dependencies from the 6lowpan
module, like lookup cid value. I don't know how possible that is for
accepting such dependency mainline for the ipv6 community. But maybe we
can implement the lookup functions then in ipv6 module (which should
always available when loading the 6lowpan module).


For your support to handle the 6CO functionality:

 - First, prepare all steps that it works with the debugfs and we have it
   mainline. (Inclusive all review notes, that we have the basic
   functionality).

 - Second, send patches for review to bluetooth, wpan mailinglist which
   adds functionality to net/ipv6 -> Then we can talk about the possible
   handling "how we can add such functionality". The netdev people
   looking much into things which slows down other stack e.g. ethernet
   and they are not happy when adding more runtime decision stuff (I
   suppose that and never tried that out). So if we add more runtime
   decision we should make this so small as possible, otherwise I don't
   see that we have a change to get it in.

   Sometimes in IPv6 stack you already see several times
   "switch (dev->type)", that's a good example that we can do our stuff
   there by checking on ARPHRD_6LOWPAN and making different stuff on
   hot paths. Then we have no additional runtime costs. But I think such
   "switch (dev->type)" doesn't exist at places were do you need the
   handling now.


I don't see that we can talk much about "how possible things are to
implement" - without any code. The 6LoWPAN code we can touch every time,
the IPv6 code is more complicated right now. :-)

- Alex
