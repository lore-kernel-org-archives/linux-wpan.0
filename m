Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:39416 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbcLHKPR (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Thu, 8 Dec 2016 05:15:17 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH v6 0/3] ieee802154: Add support for Cascoda CA8210
References: <20161206154740.2992-1-h.morris@cascoda.com>
 <EE6B2599-12C7-4B55-AFA5-E88C6BF8A942@holtmann.org>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <d45202f9-71ee-4be3-c7e4-f60d5fa07fb7@cascoda.com>
Date: Thu, 8 Dec 2016 10:15:00 +0000
MIME-Version: 1.0
In-Reply-To: <EE6B2599-12C7-4B55-AFA5-E88C6BF8A942@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: harrymorris12@gmail.com, linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>, Stefan Schmidt <stefan@osg.samsung.com>

Hi Marcel,

I copied marcel@holtmann.org on the v6, you're saying you didn't receive 
it at that address? Did you receive the other 3 parts directly?

The patch itself is 103KB.

Regards,
Harry

On 08/12/2016 06:39, Marcel Holtmann wrote:
> Hi Harry,
>
>> This patchset adds a new device driver, documentation and build support for
>> Cascoda's CA8210 IEEE 802.15.4 radio transceiver:
>> http://www.cascoda.com/products/ca-821x/
>>
>> v6:
>> Kernel style conformance changes
>> Additional documentation
>> More meaningful register structs/macros
>> Removal of old TODOs
>> Removal of unnecessary macros
>> Check for safe removal of test interface
>>
>> v5:
>> +Cc: Marcel Holtmann
>>
>> v4:
>> Added allowable tx_powers and cca_ed_levels
>> Changed power units to mbm (tx_power & cca_ed_level)
>>
>> Harry Morris (3):
>>   ieee802154: Add CA8210 IEEE 802.15.4 device driver
>>   ieee802154: Add device tree documentation for CA8210
>>   ieee802154: Add entry in MAINTAINTERS for CA8210 driver
> so I am missing PATCH 1/3 again. How large is it? You need to put me on CC if it does not go via vger.kernel.org.
>
> Regards
>
> Marcel
>
>
