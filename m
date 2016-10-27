Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:45124 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935890AbcJ0Ojw (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 27 Oct 2016 10:39:52 -0400
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH 2/3] ieee802154: Add device tree documentation for CA8210
References: <20161024150449.11132-1-h.morris@cascoda.com>
 <20161024150449.11132-3-h.morris@cascoda.com>
 <ff139ca6-38c3-bd73-2ecc-41a4b6d32388@osg.samsung.com>
 <2748cec9-ea8a-7b05-5f67-2a0c0e5756e3@cascoda.com>
 <4a3b56c9-7b90-fb55-4cf5-f77ca51a6f21@osg.samsung.com>
 <b0ded04e-c2d8-e0a6-b735-57f56a821b9c@osg.samsung.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <fb0955b9-3e38-fec6-7775-8da343a27a26@cascoda.com>
Date: Thu, 27 Oct 2016 10:52:19 +0100
MIME-Version: 1.0
In-Reply-To: <b0ded04e-c2d8-e0a6-b735-57f56a821b9c@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Stefan,

On 26/10/2016 23:51, Stefan Schmidt wrote:
> Hello.
>
> On 27/10/16 00:33, Stefan Schmidt wrote:
>> Hello.
>>
>> On 25/10/16 18:36, Harry Morris wrote:
>>> Hi Stefan,
>>>
>>> On 25/10/2016 16:54, Stefan Schmidt wrote:
>>>> Start should with a capital S here as you do on all other lines. Total
>>>> nitpick. :)
>>> Perfect, I'm sure there's a few more elsewhere I've missed
>>>>> +    - reg: Controlling chip select
>>>>> +    - spi-max-frequency:    Maximum clock speed, should be *less 
>>>>> than*
>>>>> +                            4000000
>>>>> +    - spi-cpol:             Invert clock polarity
>>>>
>>>> Is this a mandatory field for the bindings? I would expect one being
>>>> the default and used while the other one being an optional property
>>>> and only used when the hardware setup needs this. Does this make 
>>>> sense?
>>> I'm afraid not, my understanding is that the spi-cpol property is used
>>> by the spi master driver rather than the device driver, so if I need
>>> CPOL=1 (which the CA8210 always does) then the user doesn't have a
>>> choice but to specify spi-cpol here? As omitting would cause the spi
>>> master to use CPOL=0 for the attached slave.
>>
>> I would expect there is a way to set this in the driver itself as it is
>> the default and the only working mode. Having to set it in the device
>> tree bindings seems odd as this is really no option or parameter that
>> can be changed.
>>
>> Did you look around in other SPI driver so see how they handle such a
>> situation?
>
> I did look around myself quickly and it seems indeed the way to set 
> the clock polarity. Just keep it. Maybe adjust the description to 
> "Requires invert clock polarity".

I'm not sure which is the "correct" approach but I think you're right 
actually, I can indeed set the mode in the spi_device struct from the 
driver, eliminating the need to invert the polarity in the device tree. 
Since the mode is fixed for the hardware I agree it makes more sense to 
set it in the driver rather than the device tree. I'm happy to make the 
change.

Thanks,

Harry

