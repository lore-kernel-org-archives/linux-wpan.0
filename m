Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:47899 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753651AbdKFPkt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 6 Nov 2017 10:40:49 -0500
Subject: Re: [PATCH 10/14] ieee802154: ca8210: use __func__ macro for debug
 messages
References: <20170922121405.31789-1-stefan@osg.samsung.com>
 <20170922121405.31789-11-stefan@osg.samsung.com>
 <4af3a24a-65a9-2116-2712-fe544a3ef89a@cascoda.com>
From: Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <8f47d1b8-278a-81df-948d-aa4d32622e98@datenfreihafen.org>
Date: Mon, 6 Nov 2017 16:40:47 +0100
MIME-Version: 1.0
In-Reply-To: <4af3a24a-65a9-2116-2712-fe544a3ef89a@cascoda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: h.morris@cascoda.com, Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org
Cc: Alexander Aring <aring@mojatatu.com>, michael.hennerich@analog.com, varkabhadram@gmail.com, alan@signal11.us

Hello.

On 06.11.2017 16:32, Harry Morris wrote:
> On 22/09/2017 13:14, Stefan Schmidt wrote:
>> Instead of having the function name hard-coded (it might change and we
>> forgot to update them in the debug output) we can use __func__ instead
>> and also shorter the line so we do not need to break it.
>> Found by checkpatch.
>>
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
>> ---
>>   drivers/net/ieee802154/ca8210.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ieee802154/ca8210.c
>> b/drivers/net/ieee802154/ca8210.c
>> index 66829055aa8b..26e04c9176a4 100644
>> --- a/drivers/net/ieee802154/ca8210.c
>> +++ b/drivers/net/ieee802154/ca8210.c
>> @@ -924,7 +924,7 @@ static int ca8210_spi_transfer(
>>       priv = spi_get_drvdata(spi);
>>       reinit_completion(&priv->spi_transfer_complete);
>>   -    dev_dbg(&spi->dev, "ca8210_spi_transfer called\n");
>> +    dev_dbg(&spi->dev, "%s called\n", __func__);
>>         cas_ctl = kmalloc(sizeof(*cas_ctl), GFP_ATOMIC);
>>       if (!cas_ctl)
>> @@ -1898,7 +1898,7 @@ static int ca8210_net_rx(struct ieee802154_hw
>> *hw, u8 *command, size_t len)
>>       unsigned long flags;
>>       u8 status;
>>   -    dev_dbg(&priv->spi->dev, "ca8210_net_rx(), CmdID = %d\n",
>> command[0]);
>> +    dev_dbg(&priv->spi->dev, "%s: CmdID = %d\n", __func__, command[0]);
>>         if (command[0] == SPI_MCPS_DATA_INDICATION) {
>>           /* Received data */
>> @@ -1948,7 +1948,7 @@ static int ca8210_skb_tx(
>>       struct secspec secspec;
>>       unsigned int mac_len;
>>   -    dev_dbg(&priv->spi->dev, "ca8210_skb_tx() called\n");
>> +    dev_dbg(&priv->spi->dev, "%s called\n", __func__);
>>         /* Get addressing info from skb - ieee802154 layer creates a full
>>        * packet
>> @@ -2051,7 +2051,7 @@ static int ca8210_xmit_async(struct
>> ieee802154_hw *hw, struct sk_buff *skb)
>>       struct ca8210_priv *priv = hw->priv;
>>       int status;
>>   -    dev_dbg(&priv->spi->dev, "calling ca8210_xmit_async()\n");
>> +    dev_dbg(&priv->spi->dev, "calling %s\n", __func__);
>>         priv->tx_skb = skb;
>>       priv->async_tx_pending = true;
> 
> Acked-by: Harry Morris <h.morris@cascoda.com>

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt

> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-wpan" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
