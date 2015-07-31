Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55293 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbbGaIyK (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 31 Jul 2015 04:54:10 -0400
From: Stefan Schmidt <stefan@osg.samsung.com>
Subject: Re: [PATCH bluetooth-next 2/2] mac802154: fix wpan mac setting while
 lowpan
References: <1437742905-5921-1-git-send-email-alex.aring@gmail.com>
 <1437742905-5921-3-git-send-email-alex.aring@gmail.com>
 <55BA4E28.9010904@osg.samsung.com> <20150730225233.GC1037@omega>
Message-ID: <55BB37AC.3060302@osg.samsung.com>
Date: Fri, 31 Jul 2015 10:54:04 +0200
MIME-Version: 1.0
In-Reply-To: <20150730225233.GC1037@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 31/07/15 00:52, Alexander Aring wrote:
> On Thu, Jul 30, 2015 at 06:17:44PM +0200, Stefan Schmidt wrote:
>> Hello.
>>
>> On 24/07/15 15:01, Alexander Aring wrote:
>>> If we currently change the mac address inside the wpan interface while
>>> we have a lowpan interface on top of the wpan interface, the mac address
>>> setting doesn't reach the lowpan interface. The effect would be that the
>>> IPv6 lowpan interface has the old SLAAC address and isn't working
>>> anymore because the lowpan interface use in internal mechanism sometimes
>>> dev->addr which is the old mac address of the wpan interface.
>>>
>>> This patch checks if a wpan interface belongs to lowpan interface, if
>>> yes then we need to check if the lowpan interface is down and change the
>>> mac address also at the lowpan interface. When the lowpan interface will
>>> be set up afterwards, it will use the correct SLAAC address which based
>>> on the updated mac address setting.
>>>
>>> Signed-off-by: Alexander Aring<alex.aring@gmail.com>
>> Reviewed-by: Stefan Schmidt<stefan@osg.samsung.com>
>>
>> I have a bit trouble testing it though. With iwpan we only allow to set the
>> short address while the extended address is set during device registration.
>> Removing this device also removes the connected lowpan device so I wonder
>> where we would run into this problem. Patch is fine in any case but having
> 1. have running lowpan setup
> 2. ifdown wpan only, let lowpan up
> 3. change mac (extended_addr) of wpan interface
> 4. do it up again
What confused me was that I had to get wpan and lowpan down. After that 
the patches do as said. It does not work before but with the patches the 
address gets updated.

I only found one little problem when wpan was down but lowpan up I would 
set the new mac address and ip would error out but still set it for 
wpan. Alex send me a small follow up patch which fixes that. Should come 
squeezed in with that one as an update. With all this:

Tested-by: Stefan Schmidt <stefan@osg.samsung.com>


> -> something is wrong because the mac of lowpan isn't the same like wpan
>     anymore. We have several issues, maybe we could deal with that in
>     802.15.4 6LoWPAN code, but also the SLAAC address isn't right
>     anymore. IPv6 can deal with this address only when the interface is
>     down, because on ifup IPv6 on able interface -> the IPv6 stack will
>     generate the SLAAC address then according to the mac address.
>
>     What I mean in this case with "SLAAC" address is the standard
>     link-local address "fe:80::$EUI64_ADDRESS_WITH_UE_BIT/64"


As sidenote I have just seen that your patch subject is missing 
something at the end. I think you meant:

mac802154: fix wpan mac setting while lowpan is up

or similar. Not sure if you want to re-spin for this.

regards
Stefan Schmidt
