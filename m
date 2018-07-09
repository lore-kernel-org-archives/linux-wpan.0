Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-by2nam03on0060.outbound.protection.outlook.com ([104.47.42.60]:11346
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753970AbeGIIrm (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 9 Jul 2018 04:47:42 -0400
Reply-To: <michael.hennerich@analog.com>
Subject: Re: [PATCH] net: ieee802154: adf7242: Fix erroneous RX enable
References: <20180625134951.14227-1-alexandru.ardelean@analog.com>
 <1a000597-d474-a5c8-7a03-e852d6ca08e0@datenfreihafen.org>
From: Michael Hennerich <michael.hennerich@analog.com>
Message-ID: <bb288114-4534-18cc-f2d2-c44516e6f010@analog.com>
Date: Mon, 9 Jul 2018 10:51:26 +0200
MIME-Version: 1.0
In-Reply-To: <1a000597-d474-a5c8-7a03-e852d6ca08e0@datenfreihafen.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>, Alexandru Ardelean <alexandru.ardelean@analog.com>, linux-wpan@vger.kernel.org, stefan@osg.samsung.com

On 05.07.2018 11:30, Stefan Schmidt wrote:
> Hello.
> 
> [Just back from a a few weeks leave and catching up]
> 
> On 25.06.2018 15:49, Alexandru Ardelean wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Only enable RX mode if the netdev is opened.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>> ---
>>   drivers/net/ieee802154/adf7242.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
>> index 3e85e9500233..0a240a3f7817 100644
>> --- a/drivers/net/ieee802154/adf7242.c
>> +++ b/drivers/net/ieee802154/adf7242.c
>> @@ -739,7 +739,10 @@ static int adf7242_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>>   	adf7242_write_reg(lp, REG_CH_FREQ1, freq >> 8);
>>   	adf7242_write_reg(lp, REG_CH_FREQ2, freq >> 16);
>>   
>> -	return adf7242_cmd(lp, CMD_RC_RX);
>> +	if (test_bit(FLAG_START, &lp->flags))
>> +		return adf7242_cmd_rx(lp);
>> +	else
>> +		return adf7242_cmd(lp, CMD_RC_PHY_RDY);
> 
> What is the difference between the CMD_RC_PHY_RDY and the CMD_RC_RX
> command here. From the commit log I would have expected the if check but
> not a change in the issued command?


The device must be in PHY_RDY state while changing the channel.
The difference is that in CMD_RC_RX the device is in RX mode,
and it will generate receive interrupts. The issue was that the device 
erroneously entered this state even when the netdev was stopped.
This patch makes sure that the device stays in PHY_RDY state if the 
device isn't started.



-- 
Greetings,
Michael

--
Analog Devices GmbH      Otl-Aicher Strasse 60-64      80807 München
Sitz der Gesellschaft München, Registergericht München HRB 40368,
Geschäftsführer: Peter Kolberg, Ali Raza Husain, Eileen Wynne
