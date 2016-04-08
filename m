Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:53376 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751707AbcDHRhx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 8 Apr 2016 13:37:53 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 1/3] ieee802154: add security bit check function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <56E69A72.8000203@osg.samsung.com>
Date: Fri, 8 Apr 2016 10:37:48 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <3E4C2E09-2ABD-4B1B-8C97-78D802EF4A89@holtmann.org>
References: <1457633643-12535-1-git-send-email-web+oss@zopieux.com> <56E69A72.8000203@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: web+oss@zopieux.com, linux-wpan@vger.kernel.org, Alexander Aring <aar@pengutronix.de>

Hi Alexandre,

> Details about the commit author and SOB handling here.
> The from line lists you but in the SOB section below Alexander signed it off.
> This is a mismatch. As far as I understood it Alexander did the initial code after your report and you worked with it and tested it.
> 
> In that case having you as author (as you are submitting the patch here) and _both_ off you as sign offs would be correct imho.
>> 
>> ieee802154_is_secen checks if the 802.15.4 security bit is set in the
>> frame control field.
>> 
>> Signed-off-by: Alexander Aring <aar@pengutronix.de>
>> Reported-by: Alexandre Macabies <web+oss@zopieux.com>
>> Tested-by: Alexandre Macabies <web+oss@zopieux.com>
>> ---
>>  include/linux/ieee802154.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/include/linux/ieee802154.h b/include/linux/ieee802154.h
>> index d3e4156..56090f1 100644
>> --- a/include/linux/ieee802154.h
>> +++ b/include/linux/ieee802154.h
>> @@ -218,6 +218,7 @@ enum {
>>  /* frame control handling */
>>  #define IEEE802154_FCTL_FTYPE		0x0003
>>  #define IEEE802154_FCTL_ACKREQ		0x0020
>> +#define IEEE802154_FCTL_SECEN		0x0004
>>  #define IEEE802154_FCTL_INTRA_PAN	0x0040
>>    #define IEEE802154_FTYPE_DATA		0x0001
>> @@ -233,6 +234,15 @@ static inline int ieee802154_is_data(__le16 fc)
>>  }
>>    /**
>> + * ieee802154_is_secen - check if Security bit is set
>> + * @fc: frame control bytes in little-endian byteorder
>> + */
>> +static inline bool ieee802154_is_secen(__le16 fc)
>> +{
>> +	return fc & cpu_to_le16(IEEE802154_FCTL_SECEN);
>> +}
>> +
>> +/**
>>   * ieee802154_is_ackreq - check if acknowledgment request bit is set
>>   * @fc: frame control bytes in little-endian byteorder
>>   */
> 
> Code looks fine. With the SOB fixed you get my:
> 
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>

can I expect a new series with this fixed?

Regards

Marcel

