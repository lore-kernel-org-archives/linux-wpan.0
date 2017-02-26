Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:46183 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752146AbdBZGZG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Sun, 26 Feb 2017 01:25:06 -0500
Subject: Re: [PATCH v5 6/6] 6lowpan: Fix IID format for Bluetooth
References: <20170224121440.32269-1-luiz.dentz@gmail.com>
 <20170224121440.32269-7-luiz.dentz@gmail.com>
 <afc9cb44-edb6-287b-ce1d-da1c0974b5fa@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <145a7942-b86e-30e9-9542-187705c80fbf@pengutronix.de>
Date: Sun, 26 Feb 2017 07:25:03 +0100
MIME-Version: 1.0
In-Reply-To: <afc9cb44-edb6-287b-ce1d-da1c0974b5fa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, patrik.flykt@linux.intel.com, 6lo@ietf.org, devel@riot-os.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org


Hi,

On 02/26/2017 07:05 AM, Alexander Aring wrote:
> 
> Hi,
> 
> On 02/24/2017 01:14 PM, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Accourding to RFC 7668 U/L bit shall not be used:
>>
>> https://wiki.tools.ietf.org/html/rfc7668#section-3.2.2 [Page 10]:
>>
>>    In the figure, letter 'b' represents a bit from the
>>    Bluetooth device address, copied as is without any changes on any
>>    bit.  This means that no bit in the IID indicates whether the
>>    underlying Bluetooth device address is public or random.
>>
>>    |0              1|1              3|3              4|4              6|
>>    |0              5|6              1|2              7|8              3|
>>    +----------------+----------------+----------------+----------------+
>>    |bbbbbbbbbbbbbbbb|bbbbbbbb11111111|11111110bbbbbbbb|bbbbbbbbbbbbbbbb|
>>    +----------------+----------------+----------------+----------------+
>>
>> Because of this the code cannot figure out the address type from the IP
>> address anymore thus it makes no sense to use peer_lookup_ba as it needs
>> the peer address type.
>>
> 
> I am still not quite 100% of this and want to leave my opinion about this
> handling which can be interpreted in a different way.
> 
> The RFC says here:
> 
> Following the guidance of [RFC7136], a 64-bit
> Interface Identifier (IID) is formed from the 48-bit Bluetooth device
> address by inserting two octets, with hexadecimal values of 0xFF and
> 0xFE in the middle of the 48-bit Bluetooth device address as shown in
> Figure 6. 

Okay, they said from IID from the 48-bit address. 

And IID is what you need here and what [RFC7136] describes as result,
so I think you are right.

There is no need for special u/l bitflip or link-layer multicast handling.

- Alex
