Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33310 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbbE2Ib3 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Fri, 29 May 2015 04:31:29 -0400
Message-ID: <556823DD.5010706@osg.samsung.com>
Date: Fri, 29 May 2015 10:31:25 +0200
From: Stefan Schmidt <stefan@osg.samsung.com>
MIME-Version: 1.0
Subject: Re: [PATCH bluetooth-next 1/4] ieee802154/atusb: Add function for
 partial register writes
References: <1432849607-24491-1-git-send-email-stefan@osg.samsung.com> <1432849607-24491-2-git-send-email-stefan@osg.samsung.com> <55680E68.6030001@gmail.com>
In-Reply-To: <55680E68.6030001@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>

Hello.

On 29/05/15 08:59, Varka Bhadram wrote:
> Hi Stefan,
>
> I found two checkpatch issues on this patch.. See inline
>
Thanks for letting me know. Will fix and submit v2.

regards
Stefan Schmidt

> On 05/29/2015 03:16 AM, Stefan Schmidt wrote:
>
>> From: Stefan Schmidt <s.schmidt@samsung.com>
>>
>> With this function we can set individual bits in the registers if 
>> needed.
>> With the old SR_VALUE macro we could only set one bit in the register
>> which was ok for some scenarios but not for all. With this subreg write
>> function we can now set more bits defined by the mask while not touching
>> the rest.
>>
>> We start using it for the current SR_VALUE use case and will use it more
>> in upcoming patches.
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>   drivers/net/ieee802154/atusb.c | 44 
>> +++++++++++++++++++++++++-----------------
>>   1 file changed, 26 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/atusb.c 
>> b/drivers/net/ieee802154/atusb.c
>> index 5b6bb9a..93431a5 100644
>> --- a/drivers/net/ieee802154/atusb.c
>> +++ b/drivers/net/ieee802154/atusb.c
>> @@ -58,17 +58,6 @@ struct atusb {
>>       uint8_t tx_ack_seq;        /* current TX ACK sequence number */
>>   };
>>   -/* at86rf230.h defines values as <reg, mask, shift> tuples. We use 
>> the more
>> - * traditional style of having registers and or-able values. SR_REG 
>> extracts
>> - * the register number. SR_VALUE uses the shift to prepare a value 
>> accordingly.
>> - */
>> -
>> -#define __SR_REG(reg, mask, shift)    (reg)
>> -#define SR_REG(sr)            __SR_REG(sr)
>> -
>> -#define __SR_VALUE(reg, mask, shift, val)    ((val) << (shift))
>> -#define SR_VALUE(sr, val)            __SR_VALUE(sr, (val))
>> -
>>   /* ----- USB commands without data 
>> ----------------------------------------- */
>>     /* To reduce the number of error checks in the code, we record 
>> the first error
>> @@ -130,6 +119,29 @@ static int atusb_read_reg(struct atusb *atusb, 
>> uint8_t reg)
>>       return ret >= 0 ? value : ret;
>>   }
>>   +static int atusb_write_subreg(struct atusb *atusb, uint8_t reg, 
>> uint8_t mask,
>> +                  uint8_t shift, uint8_t value)
>> +{
>> +    struct usb_device *usb_dev = atusb->usb_dev;
>> +    uint8_t orig, tmp;
>> +    int ret = 0;
>> +
>> +    dev_dbg(&usb_dev->dev, "atusb_write_subreg: 0x%02x <- 0x%02x\n",
>> +        reg, value);
>
> CHECK: Alignment should match open parenthesis
> #56: FILE: drivers/net/ieee802154/atusb.c:130:
> +    dev_dbg(&usb_dev->dev, "atusb_write_subreg: 0x%02x <- 0x%02x\n",
> +        reg, value);
>
>> +
>> +    orig = atusb_read_reg(atusb, reg);
>> +
>> +    /* Write the value only into that part of the register which is 
>> allowed
>> +     * by the mask. All other bits stay as before. */
>
> WARNING: networking block comments put the trailing */ on a separate line
> #61: FILE: drivers/net/ieee802154/atusb.c:135:
> +     * by the mask. All other bits stay as before. */
>
> regards,
>

