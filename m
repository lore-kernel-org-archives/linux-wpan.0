Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:35125
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750823AbdISMhb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 19 Sep 2017 08:37:31 -0400
Subject: Re: Request for help/pointers -- 6LoWPAN over a VHF radio
References: <63F00C15-E887-4F18-A348-C17DCECEDB7E@ntnu.no>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <33fe296d-2c1f-ef59-5e72-806de2bb9bcb@osg.samsung.com>
Date: Tue, 19 Sep 2017 14:37:27 +0200
MIME-Version: 1.0
In-Reply-To: <63F00C15-E887-4F18-A348-C17DCECEDB7E@ntnu.no>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Palma <david.palma@ntnu.no>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hello.

On 09/19/2017 12:06 PM, David Palma wrote:
> Hi,
> 
> I have a couple questions about how to use 6LoWPAN over a VHF radio[1], which has a serial interface and supports a few radio operating modes[2] but not 802.15.4. > Is it possible to use the kernel's IEEE 802.15.4 implementation to do 
this?

There exists a variety of IPv6 adaption, often grouped under the the 
term 6lo by IETF, in the Linux Kernel we use it for 802.15.4 and 
Bluetooth only so far.

If you can use our 802.15.4 mac implementation over a phy that was not 
designed for 15.4 depends on what the phy does offer. Address length, 
CRC, PDU size, etc.

> If possible, where should I start? I believe this would a SoftMAC situation, but am not sure.

I had a brief look at the user manual of the device you have been 
referring to and with the normal serial interface over UART there is no 
way of using the mac802154.

The serial interface communication is on a very high level already and 
does abstract all kind of phy details which would be needed (hardMAC - 
MAC layer inside the hardware or firmware). If there is a different 
firmware version which exposes the phy details over the serial link this 
can be thought about. But with the docs I have seen this would not be 
possible.

They offer a SLIP approach to use the device under linux, but I guess 
that is not what you are after. :)

regards
Stefan Schmidt
