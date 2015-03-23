Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34712 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751935AbbCWDek (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 22 Mar 2015 23:34:40 -0400
Received: by pdbni2 with SMTP id ni2so173815226pdb.1
        for <linux-wpan@vger.kernel.org>; Sun, 22 Mar 2015 20:34:39 -0700 (PDT)
Message-ID: <550F89BF.8050405@gmail.com>
Date: Mon, 23 Mar 2015 09:04:23 +0530
From: Varka Bhadram <varkabhadram@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 2/3] cc2520: add set transmit power support
References: <1426836141-21528-1-git-send-email-varkab@cdac.in> <1426836141-21528-2-git-send-email-varkab@cdac.in> <20150320153019.GB3952@omega>
In-Reply-To: <20150320153019.GB3952@omega>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On 03/20/2015 09:00 PM, Alexander Aring wrote:
> Hi,
>
> On Fri, Mar 20, 2015 at 12:52:19PM +0530, Varka Bhadram wrote:
>> Signed-off-by: Varka Bhadram <varkab@cdac.in>
>> ---
>>   drivers/net/ieee802154/cc2520.c |   56 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ieee802154/cc2520.c b/drivers/net/ieee802154/cc2520.c
>> index f833b8b..f96cc50 100644
>> --- a/drivers/net/ieee802154/cc2520.c
>> +++ b/drivers/net/ieee802154/cc2520.c
>> @@ -53,6 +53,17 @@
>>   #define	CC2520_MAXCHANNEL		26
>>   #define	CC2520_CHANNEL_SPACING		5
>>   
>> +/* Tx power values */
>> +#define CC2520_TXPOWER_0		0x03 /* -18dbm */
>> +#define CC2520_TXPOWER_1		0x2c /* -7dbm */
>> +#define CC2520_TXPOWER_2		0x88 /* -4dbm */
>> +#define CC2520_TXPOWER_3		0x81 /* -2dbm */
>> +#define CC2520_TXPOWER_4		0x32 /* 0dbm */
>> +#define CC2520_TXPOWER_5		0x13 /* 1dbm */
>> +#define CC2520_TXPOWER_6		0xab /* 2dbm */
>> +#define CC2520_TXPOWER_7		0xf2 /* 3dbm */
>> +#define CC2520_TXPOWER_8		0xf7 /* 5dbm */
>> +
>>   /* command strobes */
>>   #define	CC2520_CMD_SNOP			0x00
>>   #define	CC2520_CMD_IBUFLD		0x02
>> @@ -628,6 +639,48 @@ cc2520_filter(struct ieee802154_hw *hw,
>>   	return 0;
>>   }
>>   
>> +static int
>> +cc2520_set_txpower(struct ieee802154_hw *hw, int db)
>> +{
> our netlink attribute is s8, maybe we should fix the mac layer at first
> and change the int to s8.

Ok. I will look into that.

> - Alex


-- 
Varka Bhadram

