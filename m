Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19152 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428AbbGMNJq (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Mon, 13 Jul 2015 09:09:46 -0400
Message-ID: <1436792982.2896.32.camel@linux.intel.com>
Subject: Re: [RFC v2 0/4] Adding stateful compression to IPHC
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Date: Mon, 13 Jul 2015 16:09:42 +0300
In-Reply-To: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
References: <1436788233-13960-1-git-send-email-lukasz.duda@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lukasz Duda <lukasz.duda@nordicsemi.no>
Cc: alex.aring@gmail.com, linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hi Lukasz,

On ma, 2015-07-13 at 13:50 +0200, Lukasz Duda wrote:
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
> to handled 6LoWPAN specific options? Do you see any other solution to make sure
> that 6CO is parsed and acted upon and still keep 6lowpan as a stand-alone module?

Have you considered that 6lowpan module could register a callback in
ipv6 module. When needed, ipv6 could then call the 6lowpan callback if
needed. This way there would be no need to embed 6lowpan functionality
to ipv6 module.


Cheers,
Jukka


