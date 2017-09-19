Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw01.it.ntnu.no ([129.241.56.174]:45870 "EHLO
        mailgw01.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750822AbdISNcs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Sep 2017 09:32:48 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Request for help/pointers -- 6LoWPAN over a VHF radio
From: David Palma <david.palma@ntnu.no>
In-Reply-To: <33fe296d-2c1f-ef59-5e72-806de2bb9bcb@osg.samsung.com>
Date: Tue, 19 Sep 2017 15:35:18 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <E44E4091-E495-4172-9D62-815B6A3363A2@ntnu.no>
References: <63F00C15-E887-4F18-A348-C17DCECEDB7E@ntnu.no>
 <33fe296d-2c1f-ef59-5e72-806de2bb9bcb@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi Stefan,

Thank you so much for taking time and helping to clarify this.

Indeed the SLIP option is available but not so attractive :)

Cheers,
--
David

> On 19 Sep 2017, at 14:37, Stefan Schmidt <stefan@osg.samsung.com> wrote:
> 
> Hello.
> 
> On 09/19/2017 12:06 PM, David Palma wrote:
>> Hi,
>> I have a couple questions about how to use 6LoWPAN over a VHF radio[1], which has a serial interface and supports a few radio operating modes[2] but not 802.15.4. > Is it possible to use the kernel's IEEE 802.15.4 implementation to do 
> this?
> 
> There exists a variety of IPv6 adaption, often grouped under the the term 6lo by IETF, in the Linux Kernel we use it for 802.15.4 and Bluetooth only so far.
> 
> If you can use our 802.15.4 mac implementation over a phy that was not designed for 15.4 depends on what the phy does offer. Address length, CRC, PDU size, etc.
> 
>> If possible, where should I start? I believe this would a SoftMAC situation, but am not sure.
> 
> I had a brief look at the user manual of the device you have been referring to and with the normal serial interface over UART there is no way of using the mac802154.
> 
> The serial interface communication is on a very high level already and does abstract all kind of phy details which would be needed (hardMAC - MAC layer inside the hardware or firmware). If there is a different firmware version which exposes the phy details over the serial link this can be thought about. But with the docs I have seen this would not be possible.
> 
> They offer a SLIP approach to use the device under linux, but I guess that is not what you are after. :)
> 
> regards
> Stefan Schmidt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

