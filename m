Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59112 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbGIKDe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Jul 2015 06:03:34 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [RFC 0/2] Adding stateful compression to IPHC
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
Date: Thu, 9 Jul 2015 12:03:28 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <A69B5B08-9C5E-432A-9F2F-330F5065B6DD@holtmann.org>
References: <1435929818-6044-1-git-send-email-lukasz.duda@nordicsemi.no>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi Lukasz,

> The following patches introduce support for stateful compression in IPHC.
> 
> Patch #1: Adding stateful compression to 6lowpan module.
> Patch #2: Enabling use of stateful compression in bluetooth_6lowpan module.
> 
> Usage of stateful compression is described in Patch #1.
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
> Also, other flags like ARO, ABRO etc. which are specified in RFC6775 need to
> be handled in the ipv6 module in order to do it in a neat way.
> Potentially the RFC6775 extensions could potentially also be used by other
> protocols than BLE and 802.15.4.
> 
> There is a need for parsing the 6CO option in ndisc.c which parses Router
> Advertisement messages. Today the function calls to IPHC (6lowpan module) are
> quite hard to implement in ndisc.c, as there is no guarantee that the 6lowpan
> module will be loaded or not. It would make sense to build 6lowpan module
> as in-build part of IPv6. The features could be compiled in by using #defines.
> 
> What do you think about moving 6lowpan as a component of IPv6 and modify ndisc.c
> to handled 6LoWPAN specific options? Do you see any other solution to make sure
> that 6CO is parsed and acted upon and still keep 6lowpan as a stand-alone module?

I am not sure that 6LoWPAN long-term should be a compile time option of IPv6. However that is certainly a possibility. If we want to discuss that, then it needs to be a discussion on the netdev mailing list with the netdev folks.

Initially the direction was to go for net/6lowpan/ and make 6LoWPAN a subsystem of its own. Making it part of IPv6 would mean this has to move into net/core/ and that needs convincing of the netdev folks.

My viewpoint of 6LoWPAN subsystem was always that besides compression, it actually becomes a full net_device abstraction. So instead of BLE and 802.15.4 allocating net_device on its own, we have something like lowpan_netdev that gets allocated by each subsystem. And then you just provide the framing functions that take the encapsulated frames and transport it over the bearer. Right now we are doing a lot of duplication in each subsystem to support 6LoWPAN. The less it takes to hook up 6LoWPAN to new bearers, the better. Moving the compression into a separate module was just the first step.

Regards

Marcel

