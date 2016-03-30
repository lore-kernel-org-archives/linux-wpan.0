Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54667 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753685AbcC3OFs (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 30 Mar 2016 10:05:48 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A589021E6A
	for <linux-wpan@vger.kernel.org>; Wed, 30 Mar 2016 10:05:46 -0400 (EDT)
Subject: Re: [PATCH v2 1/3] ieee802154: add security bit check function
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com>
 <1457988374-31220-1-git-send-email-web+oss@zopieux.com>
 <56FB9212.3040004@osg.samsung.com>
From: Alan Ott <alan@signal11.us>
Message-ID: <56FBDD39.1010301@signal11.us>
Date: Wed, 30 Mar 2016 10:05:45 -0400
MIME-Version: 1.0
In-Reply-To: <56FB9212.3040004@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, Alexandre Macabies <web+oss@zopieux.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aar@pengutronix.de>

On 03/30/2016 04:45 AM, Stefan Schmidt wrote:
> Added Alan Ott in CC.
>
> Alan, can we get your review on this? Its sit son the list for almost 
> three weeks now.
> If you are to busy just say so and we can get the ACK from Alex and 
> put them in.
>

Hi Stefan,

Sorry I've been slow on this. Thanks for forwarding. I actually went 
looking for v2 of this the other day in my inbox and it wasn't there.

Alexandre, make sure you use scripts/get_maintainer.pl to get the list 
of people you should send patches to. It looks like you put me on v1 but 
left me off v2.

For all three:
Acked-by: Alan Ott <alan@signal11.us>

Alan.

>
> On 14/03/16 21:46, Alexandre Macabies wrote:
>> ieee802154_is_secen checks if the 802.15.4 security bit is set in the
>> frame control field.
>>
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>> Signed-off-by: Alexandre Macabies <web+oss@zopieux.com>
>> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>   include/linux/ieee802154.h | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
>> index d3e4156..56090f1 100644
>> --- a/include/linux/ieee802154.h
>> +++ b/include/linux/ieee802154.h
>> @@ -218,6 +218,7 @@ enum {
>>   /* frame control handling */
>>   #define IEEE802154_FCTL_FTYPE        0x0003
>>   #define IEEE802154_FCTL_ACKREQ        0x0020
>> +#define IEEE802154_FCTL_SECEN        0x0004
>>   #define IEEE802154_FCTL_INTRA_PAN    0x0040
>>     #define IEEE802154_FTYPE_DATA        0x0001
>> @@ -233,6 +234,15 @@ static inline int ieee802154_is_data(__le16 fc)
>>   }
>>     /**
>> + * ieee802154_is_secen - check if Security bit is set
>> + * @fc: frame control bytes in little-endian byteorder
>> + */
>> +static inline bool ieee802154_is_secen(__le16 fc)
>> +{
>> +    return fc & cpu_to_le16(IEEE802154_FCTL_SECEN);
>> +}
>> +
>> +/**
>>    * ieee802154_is_ackreq - check if acknowledgment request bit is set
>>    * @fc: frame control bytes in little-endian byteorder
>>    */
>

