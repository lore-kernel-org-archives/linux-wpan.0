Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:56904
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932959AbdABPBf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2017 10:01:35 -0500
Subject: Re: [PATCH bluetooth-next 4/4] ieee802154: atusb: implement
 .set_frame_retries ops callback
References: <1480945640-3571-1-git-send-email-stefan@osg.samsung.com>
 <1480945640-3571-5-git-send-email-stefan@osg.samsung.com>
 <9a4a8de0-9057-553e-0766-957e9ed31fad@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <4066166f-d0c3-0ca2-5f00-4f5c5e5fa313@osg.samsung.com>
Date: Mon, 2 Jan 2017 16:01:31 +0100
MIME-Version: 1.0
In-Reply-To: <9a4a8de0-9057-553e-0766-957e9ed31fad@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org

Hello.

On 20/12/16 12:13, Alexander Aring wrote:
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
> Because this will set _currently_ when one interface comes first time up.
> I say currently here, because we could change tx parameters on other
> way... we just need to be sure that no other tx is currently running
> anymore... and then change register values for tx parameters.
>
> One argument +1 to use xmit_async, with workqueue inside the driver we
> have no change to get knowledge about locking tx in upper-layer..., but
> this is another topic. :-)
>
>> +	return atusb_write_subreg(atusb, SR_MAX_FRAME_RETRIES, retries);
>> +}
>> +
>> +static int
>>  atusb_set_promiscuous_mode(struct ieee802154_hw *hw, const bool on)
>>  {
>>  	struct atusb *atusb = hw->priv;
>> @@ -584,6 +599,7 @@ static const struct ieee802154_ops atusb_ops = {
>>  	.set_cca_mode		= atusb_set_cca_mode,
>>  	.set_cca_ed_level	= atusb_set_cca_ed_level,
>>  	.set_csma_params	= atusb_set_csma_params,
>> +	.set_frame_retries	= atusb_set_frame_retries,
>>  	.set_promiscuous_mode	= atusb_set_promiscuous_mode,
>>  };
>>
>> @@ -754,7 +770,8 @@ static int atusb_probe(struct usb_interface *interface,
>>
>>  	hw->parent = &usb_dev->dev;
>>  	hw->flags = IEEE802154_HW_TX_OMIT_CKSUM | IEEE802154_HW_AFILT |
>> -		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS;
>> +		    IEEE802154_HW_PROMISCUOUS | IEEE802154_HW_CSMA_PARAMS |
>> +		    IEEE802154_HW_FRAME_RETRIES;
>>
>
> You should set this flag only if it's new firmware... But not using
> TX_ARET has also other effects... It's good now that the firmware use
> TX_ARET per default.
>
> The current change is that old firmware users can't bring the interface
> anymore up, because it fails with -EINVAL and not chance to turn it off. :-)

Sorry for not catching this earlier. I tested with old and new firmware 
now and sent a patch that fixes this problem for me.

regards
Stefan Schmidt
