Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728683AbfAUIDu (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 21 Jan 2019 03:03:50 -0500
Subject: Re: [RFC net-next] net: Z-Wave driver prototype
References: <20190120183315.22743-1-afaerber@suse.de>
 <5f5aa12c-604d-ca10-1873-f5f2bbe3d266@infradead.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <653e10b5-ff5f-dafc-6a4f-1569883fb68b@suse.de>
Date: Sun, 20 Jan 2019 21:26:08 +0100
MIME-Version: 1.0
In-Reply-To: <5f5aa12c-604d-ca10-1873-f5f2bbe3d266@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-lpwan@lists.infradead.org, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Hi,

Am 20.01.19 um 19:56 schrieb Randy Dunlap:
> On 1/20/19 10:33 AM, Andreas Färber wrote:
>> Tested as external kernel module, so Kconfig/Makefile integration missing.
[...]
>> diff --git a/drivers/net/zwave/Makefile b/drivers/net/zwave/Makefile
>> new file mode 100644
>> index 000000000000..1a4171308c79
>> --- /dev/null
>> +++ b/drivers/net/zwave/Makefile
>> @@ -0,0 +1 @@
>> +obj-m += zwave.o
> 
> This will need a Kconfig file and a symbol so that the Makefile
> will not always build the zwave module.

Well, as I noted in the commit message you cut off, this Makefile is not
included from drivers/net/. So it should actually not get built at all,
unless you build it explicitly as module:

$ make -C /lib/modules/`uname -r`/build M=$PWD/drivers/net/zwave

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/modules.txt?id=HEAD

This RFC is nowhere near merging, so there's no point in bike-shedding
about Kconfig help texts. The Kconfig/Makefile integration depends on
the alternatives outlined in the commit message of what to make of this.
Right now it does not expose any netdev nor any other useful interfaces,
merely demonstrating that via serdev it could be handled in the kernel.

The big context here is RF ASICs vs. SDR and the layering of PHY and MAC
implementations and their user-facing (socket) interfaces. Cf. slide 24:
https://events.linuxfoundation.org/wp-content/uploads/2017/12/ELCE2018_LoRa_final_Andreas-Farber.pdf
(Z-Wave was marked in orange as not-entirely-open protocol over FSK.)

I had this Z-Wave module lying around, so I gave it a quick shot to get
a feeling for the protocol in comparison. If no one finds the RFC useful
then it can die as quickly as it came to life. :)

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
