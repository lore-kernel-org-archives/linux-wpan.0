Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:60936 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbbETIgq (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 May 2015 04:36:46 -0400
Message-ID: <555C479A.5050004@osg.samsung.com>
Date: Wed, 20 May 2015 10:36:42 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] Documentation/networking/ieee802154.txt: fix various
 inaccuracies.
References: <cover.1432064518.git.buytenh@wantstofly.org> <20150519195000.GN11014@wantstofly.org> <148935A5-4809-4999-9C45-445A9768A7DC@holtmann.org>
In-Reply-To: <148935A5-4809-4999-9C45-445A9768A7DC@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>, Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hello.

On 20/05/15 00:05, Marcel Holtmann wrote:
> Hi Lennert,
>
>> * Update the linux-zigbee git:// repository URL.
>>
>> * The IEEE 802.15.4 MLME based netlink operations are documented
>>   in include/linux/nl802154.h, not in include/net/nl802154.h.
>>
>> * The hardmac example driver 'fakehard' was removed some time ago.
>>
>> * The IEEE 802.15.4 device drivers live in drivers/net/ieee802154/,
>>   not in drivers/ieee802154/.
>>
>> * The IEEE 802.15.4 MTU is 127 bytes, not 128 bytes.
>>
>> * Some of the 6LoWPAN code lives in net/6lowpan/.
>>
>> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
>> ---
>> Documentation/networking/ieee802154.txt | 25 ++++++++++++-------------
>> 1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/networking/ieee802154.txt b/Documentation/networking/ieee802154.txt
>> index 22bbc72..ed08768 100644
>> --- a/Documentation/networking/ieee802154.txt
>> +++ b/Documentation/networking/ieee802154.txt
>> @@ -30,8 +30,8 @@ int sd = socket(PF_IEEE802154, SOCK_DGRAM, 0);
>>
>> The address family, socket addresses etc. are defined in the
>> include/net/af_ieee802154.h header or in the special header
>> -in our userspace package (see either linux-zigbee sourceforge download page
>> -or git tree at git://linux-zigbee.git.sourceforge.net/gitroot/linux-zigbee).
>> +in our userspace package (see either linux-zigbee sourceforge download
>> +page or git tree at git://git.code.sf.net/p/linux-zigbee/linux-zigbee).
> I assumed Alex created a linux-wpan userspace repository. I think if we update the text here, we should reference that one.
>
Indeed. Additionally we should also remove the ZigBee references as the 
linux-wpan stack only cares about 802.15.4 and 6LoWPAN.

Maybe mention the new project homepage (http://wpan.cakelab.org/) and 
new userspace utils wpan-tools as well.

regards
Stefan Schmidt
