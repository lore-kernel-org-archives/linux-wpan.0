Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:56359 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752117AbcLGMAW (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 7 Dec 2016 07:00:22 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH v6 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20161206154740.2992-1-h.morris@cascoda.com>
 <20161206154740.2992-2-h.morris@cascoda.com>
 <84426f94-8bb6-06d7-c166-b97929afc0ee@osg.samsung.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <74e35a5a-1707-f186-644d-a020b57c185f@cascoda.com>
Date: Wed, 7 Dec 2016 12:00:06 +0000
MIME-Version: 1.0
In-Reply-To: <84426f94-8bb6-06d7-c166-b97929afc0ee@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: harrymorris12@gmail.com, aar@pengutronix.de, marcel@holtmann.org

Hi Stefan,

On 06/12/2016 21:25, Stefan Schmidt wrote:
> Hello.
>
> First of all thanks for going and fixing almost all of the checkpatch 
> warnings. The rest seems ok to stay as is.
> I would expect you made sure that the case where a msleep() could take 
> up to 20ms in cases it is < 20ms are no problems in your driver.

Great, and yes those 1ms msleeps are all a part of "Some condition isn't 
fulfilled yet so wait for <some time> and check again", so if it's a bit 
longer it's totally fine.

>
> On 06/12/16 16:47, harrymorris12@gmail.com wrote:
>> From: Harry Morris <h.morris@cascoda.com>
>>
>> Add driver source and config for softMAC implementation of Cascoda's 
>> CA8210
>> IEEE 802.15.4 transceiver device. The driver mimics a common PHY-only
>> implementation despite the CA8210 being a hardMAC device which 
>> exposes a SAP
>> interface to the fully integrated MAC.
>>
>> The chip is a modem-only device with an integrated processor which 
>> runs the
>> 802.15.4 MAC. The chip communicates via full-duplex SPI with 
>> additional pins
>> for NIRQ and NRESET. The chip can also output its 16MHz clock to a 
>> GPIO with a
>> configurable divider.
>>
>> The driver can be configured to implement a debugfs node that 
>> provides access
>> to the SAP-based API to drive mechanisms not currently supported by the
>> standard kernel interface.
>>
>> Signed-off-by: Harry Morris <h.morris@cascoda.com>
>
> From what I can see all my review comments have been addressed over 
> this 7 iterations. Thanks. :-)

No worries,

Regards,
Harry
