Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:58107 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755148AbcLTLVG (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Tue, 20 Dec 2016 06:21:06 -0500
Subject: Re: [PATCH bluetooth-next 4/4] ieee802154: atusb: implement
 .set_frame_retries ops callback
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
 <1480945640-3571-5-git-send-email-stefan@osg.samsung.com>
 <9a4a8de0-9057-553e-0766-957e9ed31fad@pengutronix.de>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <90358031-baa2-5dc0-0c91-436961f9d2cc@pengutronix.de>
Date: Tue, 20 Dec 2016 12:21:00 +0100
MIME-Version: 1.0
In-Reply-To: <9a4a8de0-9057-553e-0766-957e9ed31fad@pengutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On 12/20/2016 12:13 PM, Alexander Aring wrote:
> 
> Hi,
> 
> On 12/05/2016 02:47 PM, Stefan Schmidt wrote:
>> From firmware version 0.3 onwards we use the TX_ARET mode allowing for automatic
>> frame retransmissions. To actually make use of this feature we need to implement
>> the callback for setting the frame retries.
>>
>> If the firmware version is to old print a warning and return with invalid value.
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>  drivers/net/ieee802154/atusb.c | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
>> index 3ed34cc..1253f86 100644
>> --- a/drivers/net/ieee802154/atusb.c
>> +++ b/drivers/net/ieee802154/atusb.c
>> @@ -546,6 +546,21 @@ atusb_set_csma_params(struct ieee802154_hw *hw, u8 min_be, u8 max_be, u8 retries
>>  }
>>  
>>  static int
>> +atusb_set_frame_retries(struct ieee802154_hw *hw, s8 retries)
>> +{
>> +	struct atusb *atusb = hw->priv;
>> +	struct device *dev = &atusb->usb_dev->dev;
>> +
>> +	if (atusb->fw_ver_maj == 0 && atusb->fw_ver_min < 3) {
>> +		dev_info(dev, "Automatic frame retransmission is only available from "
>> +			"firmware version 0.3. Please update if you want this feature.");
>> +		return -EINVAL;
>> +	}
>> +
> 
> I think the user has not change anymore to use atusb driver with new
> firmware now.
> 

meant, has no chance anymore to use new atusb driver with old
firmware...

- Alex
