Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39669 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751140AbaHPPtS (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Sat, 16 Aug 2014 11:49:18 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway1.nyi.internal (Postfix) with ESMTP id 4BEDB21479
	for <linux-wpan@vger.kernel.org>; Sat, 16 Aug 2014 11:49:16 -0400 (EDT)
Message-ID: <53EF7D80.8090202@signal11.us>
Date: Sat, 16 Aug 2014 11:49:20 -0400
From: Alan Ott <alan@signal11.us>
MIME-Version: 1.0
Subject: Re: [PATCHv2 linux-wpan] ieee802154: mrf24j40: Add support for MRF24J40MC
References: <1408035166-6336-1-git-send-email-simon.vincent@xsilon.com> <20140814181013.GD19852@omega>
In-Reply-To: <20140814181013.GD19852@omega>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>, Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

On 08/14/2014 02:10 PM, Alexander Aring wrote:
> Hi,
>
> On Thu, Aug 14, 2014 at 05:52:46PM +0100, Simon Vincent wrote:
>> The MRF24J40MC module has an external amplifier which should be enabled.
>>
>> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>
>> ---
>>   drivers/net/ieee802154/mrf24j40.c | 40 +++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
>> index 9e6a124..7950d01 100644
>> --- a/drivers/net/ieee802154/mrf24j40.c
>> +++ b/drivers/net/ieee802154/mrf24j40.c
>> @@ -43,6 +43,8 @@
>>   #define REG_TXSTBL   0x2E  /* TX Stabilization */
>>   #define REG_INTSTAT  0x31  /* Interrupt Status */
>>   #define REG_INTCON   0x32  /* Interrupt Control */
>> +#define REG_GPIO     0x33  /* GPIO */
>> +#define REG_TRISGPIO 0x34  /* GPIO direction */
>>   #define REG_RFCTL    0x36  /* RF Control Mode Register */
>>   #define REG_BBREG1   0x39  /* Baseband Registers */
>>   #define REG_BBREG2   0x3A  /* */
>> @@ -63,6 +65,7 @@
>>   #define REG_SLPCON1    0x220
>>   #define REG_WAKETIMEL  0x222  /* Wake-up Time Match Value Low */
>>   #define REG_WAKETIMEH  0x223  /* Wake-up Time Match Value High */
>> +#define REG_TESTMODE   0x22F  /* Test mode */
>>   #define REG_RX_FIFO    0x300  /* Receive FIFO */
>>   
>>   /* Device configuration: Only channels 11-26 on page 0 are supported. */
>> @@ -75,6 +78,8 @@
>>   #define RX_FIFO_SIZE 144 /* From datasheet */
>>   #define SET_CHANNEL_DELAY_US 192 /* From datasheet */
>>   
>> +enum mrf24j40_modules { MRF24J40, MRF24J40MA, MRF24J40MC };
>> +
>>   /* Device Private Data */
>>   struct mrf24j40 {
>>   	struct spi_device *spi;
>> @@ -690,6 +695,35 @@ static int mrf24j40_hw_init(struct mrf24j40 *devrec)
>>   	if (ret)
>>   		goto err_ret;
>>
>> +	if (spi_get_device_id(devrec->spi)->driver_data == MRF24J40MC) {
>> +		/* Enable external amplifier */
>> +		ret = write_long_reg(devrec, REG_TESTMODE, 0xF);
>> +		if (ret)
>> +			goto err_ret;
>> +
>> +		ret = read_short_reg(devrec, REG_TRISGPIO, &val);
>> +		if (ret)
>> +			goto err_ret;
>> +
>> +		val |= 0x8;
>> +		ret = write_short_reg(devrec, REG_TRISGPIO, val);
>> +		if (ret)
>> +			goto err_ret;
>> +
>> +		ret = read_short_reg(devrec, REG_GPIO, &val);
>> +		if (ret)
>> +			goto err_ret;
>> +
>> +		val |= 0x8;
>> +		ret = write_short_reg(devrec, REG_GPIO, val);
>> +		if (ret)
>> +			goto err_ret;
>> +
>> +		ret = write_long_reg(devrec, REG_RFCON3, 0x28);
>> +		if (ret)
>> +			goto err_ret;

As I've mentioned before on this list[1], it's a waste of code space to 
check for return values from SPI transfers, because in the kernel, we 
assume that they succeed, in the same way that we assume that writes to 
memory addresses succeed[2].

There are also some magic numbers in there. I get setting the TRIS and 
GPIO single bits, that's fine. What about TESTMODE and RFCON3? What do 
0xf and 0x28 mean? If they came directly from the datasheet, cite the 
section it comes from (like I do in the initialization).

>> +	}
>> +
>>   	return 0;
>>   
>>   err_ret:
>> @@ -778,8 +813,9 @@ static int mrf24j40_remove(struct spi_device *spi)
>>   }
>>   
>>   static const struct spi_device_id mrf24j40_ids[] = {
>> -	{ "mrf24j40", 0 },
>> -	{ "mrf24j40ma", 0 },
>> +	{ "mrf24j40", MRF24J40 },
>> +	{ "mrf24j40ma", MRF24J40MA },
>> +	{ "mrf24j40mc", MRF24J40MC },

Good. I like this mechanism, and it will be very easy to add the MB as 
well when the time comes.

>>   	{ },
>>   };
>>   MODULE_DEVICE_TABLE(spi, mrf24j40_ids);
>> -- 
>> 1.9.1
>>
> I will apply this patch, but I cc the original author of this driver Alan Ott.
>
> Alan is this patch okay for you? If you don't respond in the next two days I
> assume "yes".
>

Thanks Simon, for the patch, and sorry for my long delay in reviewing it.

Alan.

[1] 
https://www.mail-archive.com/linux-zigbee-devel%40lists.sourceforge.net/msg02898.html
[2] It was a while ago, so I'm not blaming you for not seeing it, and I 
see that you made it the way you did because it matched the code in 
net-next, but the reason the code is the way it is now, is that someone 
went around me to get a patch applied (which I had previously rejected) 
to make it look this way.  That's a separate issue, but explains why I 
disagree with code which matches code that's already in the driver.

