Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53824 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794AbcHDJeH (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Aug 2016 05:34:07 -0400
Subject: Re: [PATCH linux-wpan/radvd for-upstream 1/2] device-linux: replace
 ARPHRD_IEEE802154 to ARPHRD_6LOWPAN
References: <20160802143752.12831-1-aar@pengutronix.de>
 <20160802143752.12831-2-aar@pengutronix.de>
 <CABBYNZ++YLsfPv+oR=Mwae=y+Q-wVWFmFWZfDnhssS_0xFMktw@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <cd74efa7-aed3-14bc-be5a-e172642422af@pengutronix.de>
Date: Thu, 4 Aug 2016 11:34:04 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZ++YLsfPv+oR=Mwae=y+Q-wVWFmFWZfDnhssS_0xFMktw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>


Hi,

On 08/04/2016 10:26 AM, Luiz Augusto von Dentz wrote:
> Hi Alex,
> 
> On Tue, Aug 2, 2016 at 5:37 PM, Alexander Aring <aar@pengutronix.de> wrote:
>> This patch changes the ARPHRD_IEEE802154 to ARPHRD_6LOWPAN. The IEEE
>> 802.15.4 6lowpan module changed the ARPHRD_IEEE802154 type to
>> ARPHRD_6LOWPAN. Nowadays it's use ARPHRD_6LOWPAN which is also used by
>> BTLE 6LoWPAN. Both interfaces uses an EUI64 address and the handling to
>> get the link-layer address should be the same.
> 
> Bluetooth MAC addresses are 48 bits long, it could be converted to 64
> bits to generate the so called IID but that is only to generate the
> link-local address:
> 
> https://tools.ietf.org/html/rfc7668#section-3.2.2
> 

Ah, yes sorry. This commit msg was created in a time when I just looked
into the bluetooth code ans saw dev->addr_len = 8 and trust it. :-)

Patch 2/2 will care about different address lengths.

btw:

Radvd needs the device address for option:

AdvSourceLLAddress on|off

see [0].

However Patch 2/2 will fix it, I just need to convert to a netlink
handling. I have it running now, but it looks ugly (maybe that's normal
when doing low-level netlink stuff).

I will fix the commit msg.

- Alex

[0] http://linux.die.net/man/5/radvd.conf
