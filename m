Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:58083 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938612AbcJYQqF (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 25 Oct 2016 12:46:05 -0400
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH 2/3] ieee802154: Add device tree documentation for CA8210
References: <20161024150449.11132-1-h.morris@cascoda.com>
 <20161024150449.11132-3-h.morris@cascoda.com>
 <ff139ca6-38c3-bd73-2ecc-41a4b6d32388@osg.samsung.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <2748cec9-ea8a-7b05-5f67-2a0c0e5756e3@cascoda.com>
Date: Tue, 25 Oct 2016 17:36:43 +0100
MIME-Version: 1.0
In-Reply-To: <ff139ca6-38c3-bd73-2ecc-41a4b6d32388@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: alex.aring@gmail.com

Hi Stefan,

On 25/10/2016 16:54, Stefan Schmidt wrote:
> Start should with a capital S here as you do on all other lines. Total 
> nitpick. :)
Perfect, I'm sure there's a few more elsewhere I've missed
>> +    - reg:                  Controlling chip select
>> +    - spi-max-frequency:    Maximum clock speed, should be *less than*
>> +                            4000000
>> +    - spi-cpol:             Invert clock polarity
>
> Is this a mandatory field for the bindings? I would expect one being 
> the default and used while the other one being an optional property 
> and only used when the hardware setup needs this. Does this make sense?
I'm afraid not, my understanding is that the spi-cpol property is used 
by the spi master driver rather than the device driver, so if I need 
CPOL=1 (which the CA8210 always does) then the user doesn't have a 
choice but to specify spi-cpol here? As omitting would cause the spi 
master to use CPOL=0 for the attached slave.

Regards,
Harry
