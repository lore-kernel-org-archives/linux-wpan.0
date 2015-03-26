Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:22354 "EHLO
	rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbCZEl0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 26 Mar 2015 00:41:26 -0400
From: "Ralph Droms (rdroms)" <rdroms@cisco.com>
Subject: Re: hardware recommendation
Date: Thu, 26 Mar 2015 04:41:24 +0000
Message-ID: <4E57CCC9-A879-457C-9471-9A83BA417CE5@cisco.com>
References: <8575BDE3-5617-49A9-AF9C-D0C9359E074E@cisco.com>
 <20150323075818.GA4069@omega>
In-Reply-To: <20150323075818.GA4069@omega>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2E288A2A0C50947A7485EB969E5F262@emea.cisco.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>


> On Mar 23, 2015, at 2:58 AM 3/23/15, Alexander Aring <alex.aring@gmail.com> wrote:
> 
> Hi Ralph,
> 
> welcome back.

Thanks!

> 
> On Sun, Mar 22, 2015 at 03:28:36PM +0000, Ralph Droms (rdroms) wrote:
>> What hardware - radio board, interface, Linux platform - are recommended for the 802.15.4 stack in the bluetooth-next kernel?
>> 
> 
> See [0].
> 
> Radio board:
> 
>  - I would advice a 2.4 Ghz at86rf231 or at86rf233 [1].
>     Supports async xmit handling and has the most supported hardware
>     flags. Driver is at86rf230.

OK.

> 
> Interface:
>  - What you mean with interface? Bus Interface? -> SPI. Or netlink
>    interface? -> nl802154 with wpan-tools. Don't understand the
>    question.

Bus interface.

> 
> Linux platform:
>  - I think you mean some architecture -> ARM. Then the platform, some
>    board: The transceiver at [1] was made for RPi which works well on
>    my side. But the RPi has a lack of mainline support. You have no
>    USB, this means you have also no ethernet. If you don't need
>    ethernet, then I would use a simple RPi. If you need ethernet I
>    would advice to make some adapter board to add the [1] on a
>    beaglebone [2], which have a good mainline support. This require
>    some hardware hacking skills.

[1] + Raspberry Pi is the sort of combination I was asking about.  But, I'd also like to have Ethernet as well.  I have a couple of BeagleBoard XMs; I ordered a couple of [1]s and I'll try to hack up an adapter.



>    Note: for RPi I also support you have no other support e.g. HDMI
>    output or something else. SPI with RPi works mainline perfectly.
> 
>> - Ralph
>> 
>> BTW, is this list archived?  Where?
>> 
> 
> Over google I detected that spinics archive this mailinglist [3] (but
> doesn't include the early days).
> 
> - Alex
> 
> [0] http://wpan.cakelab.org/
> [1] http://openlabs.co/store/Raspberry-Pi-802.15.4-radio
> [2] http://beagleboard.org/
> [3] http://www.spinics.net/lists/linux-wpan/
> 

