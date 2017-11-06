Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:41521 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932156AbdKFOgD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 09:36:03 -0500
Subject: Re: [PATCH] ieee802154: mrf24j40: fix incorrect mask in mrf24j40_stop
References: <20171031063127.GA6032@embeddedor.com>
 <2d784b55-8447-7581-43a3-d42f152e045b@osg.samsung.com>
From: Alan Ott <alan@signal11.us>
Message-ID: <4f966500-ec25-6390-6453-c037a05f028c@signal11.us>
Date: Mon, 6 Nov 2017 09:36:01 -0500
MIME-Version: 1.0
In-Reply-To: <2d784b55-8447-7581-43a3-d42f152e045b@osg.samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On 11/06/2017 06:13 AM, Stefan Schmidt wrote:
> Hello Alan.
>
> On 10/31/2017 07:31 AM, Gustavo A. R. Silva wrote:
>> It seems that this is a copy/paste error and the proper bit masking is:
>> BIT_TXNIE | BIT_RXIE
>>
>> This issue was detected with the help of Coccinelle.
>>
>> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> Fixes: 7d840545e5b9 ("mrf24j40: replace magic numbers")
>> ---
>>  drivers/net/ieee802154/mrf24j40.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
>> index ee7084b..cf4788d 100644
>> --- a/drivers/net/ieee802154/mrf24j40.c
>> +++ b/drivers/net/ieee802154/mrf24j40.c
>> @@ -635,7 +635,7 @@ static void mrf24j40_stop(struct ieee802154_hw *hw)
>>
>>  	/* Set TXNIE and RXIE. Disable Interrupts */
>>  	regmap_update_bits(devrec->regmap_short, REG_INTCON,
>> -			   BIT_TXNIE | BIT_TXNIE, BIT_TXNIE | BIT_TXNIE);
>> +			   BIT_TXNIE | BIT_RXIE, BIT_TXNIE | BIT_RXIE);
>>  }
>>
>>  static int mrf24j40_set_channel(struct ieee802154_hw *hw, u8 page, u8 channel)
>>
>
> Could you review this and give me your ack when you are happy so I can apply it to my tree?
>

Acked-by: Alan Ott <alan@signal11.us>

