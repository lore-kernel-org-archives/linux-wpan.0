Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:39743 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752783AbcFVUlt (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 22 Jun 2016 16:41:49 -0400
Subject: Re: [PATCH bluetooth-next 3/3] ieee802154: 6lowpan: fix intra pan id
 check
References: <20160617163450.3229-1-aar@pengutronix.de>
 <20160617163450.3229-3-aar@pengutronix.de> <576AA3E3.8080904@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <b60ac90f-4880-874b-f1a9-9163361dba9d@pengutronix.de>
Date: Wed, 22 Jun 2016 22:41:46 +0200
MIME-Version: 1.0
In-Reply-To: <576AA3E3.8080904@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de


Hi,

On 06/22/2016 04:42 PM, Stefan Schmidt wrote:
> Hello.
> 
> On 17/06/16 18:34, Alexander Aring wrote:
>> The RIOT-OS stack does send intra-pan frames but don't set the intra pan
>> flag inside the mac header. It seems this is valid frame addressing but
>> inefficient. Anyway this patch adds a new function for intra pan
>> addressing, doesn't matter if intra pan flag or source and destination
>> are the same. The newly introduction function will be used to check on
>> intra pan addressing for 6lowpan.
>>
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>> ---
>>   include/linux/ieee802154.h  |  1 +
>>   include/net/mac802154.h     | 19 +++++++++++++++++++
>>   net/ieee802154/6lowpan/rx.c |  2 +-
>>   3 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
>> index fd14815..ddb8901 100644
>> --- a/include/linux/ieee802154.h
>> +++ b/include/linux/ieee802154.h
>> @@ -50,6 +50,7 @@
>>     #define IEEE802154_EXTENDED_ADDR_LEN    8
>>   #define IEEE802154_SHORT_ADDR_LEN    2
>> +#define IEEE802154_PAN_ID_LEN        2
>>     #define IEEE802154_LIFS_PERIOD        40
>>   #define IEEE802154_SIFS_PERIOD        12
>> diff --git a/include/net/mac802154.h b/include/net/mac802154.h
>> index deb90a1..df34187 100644
>> --- a/include/net/mac802154.h
>> +++ b/include/net/mac802154.h
>> @@ -333,6 +333,25 @@ static inline unsigned char *ieee802154_skb_src_pan(__le16 fc,
>>   }
>>     /**
>> + * ieee802154_skb_is_intra_pan_addressing - checks whenever the mac addressing
>> + *    is an intra pan communication
>> + * @fc: mac header frame control field
>> + * @skb: skb where the source and destination pan should be get from
>> + */
>> +static inline bool ieee802154_skb_is_intra_pan_addressing(__le16 fc,
>> +                              const struct sk_buff *skb)
>> +{
>> +    unsigned char *dst_pan = ieee802154_skb_dst_pan(fc, skb),
>> +              *src_pan = ieee802154_skb_src_pan(fc, skb);
>> +
>> +    /* if one is NULL is no intra pan addressing */
>> +    if (!dst_pan || !src_pan)
>> +        return false;
>> +
>> +    return !memcmp(dst_pan, src_pan, IEEE802154_PAN_ID_LEN);
>> +}
> 
> This seems like a complicated way to compare two PAN IDs which are basicall le16 types. Why would you could the detour here expressing them as char *?
> 

I thought many times about how do deal with that for my current use-case
which is comparing src_pan and dst_pan.

These function delivers the pointer on mac_header where the src and dst
pan id is. To compare the src and dst pan id, we don't need to put them
on stack dealing with unaligned memory access. Also in case of intra pan
flag, then we have "dst_pan == src_pan" and I think some memcmp
implementations doesn't compare data if dst, src pointers are the same.
This is also what 802.15.4 says for the intra pan communication.

Sometimes I would like to simple compare directly on mac_header, e.g.
comparing destination address with current wpan_dev MIB addressing values
without putting these attributes on the stack. (I think this is also one
reason why we save mostly everything in byteorder like mac header).
Also dealing with pointers let us handle the none case by returning NULL.

This doesn't work every time, for different use-case we can introduce a
higher-level function which use the "getting the right pointer by frame
control field" functions, see below.

> In my opinion the ieee802154_skb_{src,dst}_pan() should just return the PAN ID as le16 value. That is what I would expect.

For this we can and should add some function without keyword "_skb_" which
maybe call the lower functionality "ieee802154_skb_{src,dst}_pan" and do
some mempcy on __le16 type and return it, but you _maybe_ need to check if
addr mode for saddr/daddr isn't none.

I say maybe here, because there exists some tweaks in 802.15.4 frame
format to decide if it's valid frame format and I think for dataframes
one (src or dst addr mode, I don't remember) can't be none, such frames
should be filtered out before deliver to packet layer, so we can sure
some things after checking on dataframes.

btw: I don't believe that we do that, such filtering and also don't
trust the hardware filters here, the hardware filters may filter such
frames or not. We don't know it so we check twice. :-)

---

I hope these arguments are enough to get this approach into kernel.

- Alex
