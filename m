Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49117 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751677AbdARJ1M (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Jan 2017 04:27:12 -0500
Subject: Re: [PATCH v7 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20170110154122.6724-1-h.morris@cascoda.com>
 <20170110154122.6724-2-h.morris@cascoda.com>
 <84e02f0a-9b85-888e-be2a-d9d72fd7b7a0@pengutronix.de>
 <02d9d99c-5cb7-2bfe-6140-5eef3d93ccc6@cascoda.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <2126830b-5721-ab9a-100f-ce607311a0ad@pengutronix.de>
Date: Wed, 18 Jan 2017 10:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <02d9d99c-5cb7-2bfe-6140-5eef3d93ccc6@cascoda.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: h.morris@cascoda.com
Cc: Harry Morris <harrymorris12@gmail.com>, linux-wpan@vger.kernel.org, stefan@osg.samsung.com, marcel@holtmann.org


Hi,

On 01/16/2017 12:47 PM, Harry Morris wrote:
> Hi Alex,
> 
> On 14/01/2017 17:13, Alexander Aring wrote:
>> Hi,
>>
>> On 01/10/2017 04:41 PM, Harry Morris wrote:
>>> <snip>
>>> +
>>> +    if (ca8210_spi_transfer(
>>> +
>>> +/**
>>> + * ca8210_xmit_async() - Asynchronously transmits a given socket buffer using
>>> + *                       the ca8210
>>> + * @hw:   ieee802154_hw of ca8210 to transmit from
>>> + * @skb:  Socket buffer to transmit
>>> + *
>>> + * Return: 0 or linux error code
>>> + */
>>> +static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>>> +{
>>> +    struct ca8210_priv *priv = hw->priv;
>>> +    int status;
>>> +
>>> +    dev_dbg(&priv->spi->dev, "calling ca8210_xmit_async()\n");
>>> +
>>> +    priv->tx_skb = skb;
>>> +    priv->async_tx_pending = true;
>>> +    status = ca8210_skb_tx(skb, priv->nextmsduhandle, priv);
>>> +    queue_delayed_work(
>>> +        priv->async_tx_workqueue,
>>> +        &priv->async_tx_timeout_work,
>>> +        msecs_to_jiffies(CA8210_DATA_CNF_TIMEOUT)
>>> +    );
>>> +    return status;
>>> +}
>> I thought you fixed now to use spi_async here. Do not a context switch
>> here to a workqueue.
>> You need to run spi_async which is allowed in non sleeping context.
> So the workqueue here is for the /timeout/ work, not the actual transmission. I'm first calling ca8210_skb_tx which is calling spi_async further down, then using the workqueue to schedule a timeout if the MCPS-DATA.confirm is not received in a reasonable time. I'm aware that the stack will have its own timeout if xmit_complete is not called but this identifies the problem more specifically. I guess I can remove it if it seems like a bad idea.
> 

this should be provide by netdev watchdog callback -> such feature need
subsystem support.

- Alex
