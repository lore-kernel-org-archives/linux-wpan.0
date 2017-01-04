Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:43074 "EHLO
        cascoda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030778AbdADNiS (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 4 Jan 2017 08:38:18 -0500
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH v6 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20161206154740.2992-1-h.morris@cascoda.com>
 <20161206154740.2992-2-h.morris@cascoda.com>
 <0aa78be5-7af1-8837-c546-16588646bc32@pengutronix.de>
 <98cb5f50-2e9b-5414-88c0-d8323a547152@cascoda.com>
 <bd8da1df-25a4-5e1b-61f9-1fc106d042fa@pengutronix.de>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <f34f0a18-0c6c-70c7-a19b-ab5f306500ce@cascoda.com>
Date: Wed, 4 Jan 2017 13:30:46 +0000
MIME-Version: 1.0
In-Reply-To: <bd8da1df-25a4-5e1b-61f9-1fc106d042fa@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: harrymorris12@gmail.com, linux-wpan@vger.kernel.org, stefan@osg.samsung.com, marcel@holtmann.org

Hi Alex,

Sorry for such a late reply, I wanted to see if I could implement the 
async spi behaviour completely before responding and it's been a pretty 
big change. (and holidays) :)

On 15/12/2016 20:06, Alexander Aring wrote:
> Hi,
>
> On 12/15/2016 02:52 PM, Harry Morris wrote:
>> Hi Alex,
>>
>> On 12/12/2016 14:27, Alexander Aring wrote:
>>> All these spi stuff is low-level spi functionality, why not simple use
>>> the spi helper functions. E.g. "spi_write_then_read" and I don't mean
>>> only just this code, I mean every code here.
>>>
>>> Low-level is _maybe_ needed if you using async api.
>> As far as I can see, I'm unable to use the helper functions because I need (effectively) manual control of the spi chip select. The way the ca8210 API works I don't know how many bytes I'm reading in total until I read the "command length" byte. So I need to read two bytes, keep the chip select asserted while I process the length and then read the rest of the data. This is the same for the tx path since the ca8210 operates in full duplex mode, so when transmitting I may also be receiving a command that is longer than what I am transmitting so there is a risk of me de-asserting the chip select too early using a helper. Maybe I'm not completely understanding how the helpers work though.
>>
> Sorry to say that, but ... this is impossible with the spi subsystem.
>
> I mean it's possible, but if you doing that there exists spi controller
> drivers/hardware stuff which doesn't support it. The cs_change property
> doesn't work on all hardware.
>
> People told me to avoid it, otherwise I could easy implement receive
> handling at at86rf230 driver to not drop cs after framebuffer read.
> Deasserting cs after framebuffer read will drop the framebuffer
> protection there and new frames can overwrite the framebuffer...
>
> We currently always read the whole framebuffer instead first fetching
> the length and then read the length only.
>
> Is something somehow possible in your case? You should be careful using
> cs_change attribute it doesn't work on all hardware.
This is possible in my case, it just reduces the bandwidth slightly. I 
have implemented this behaviour for the next patch set.

>>>> +    msdulen = data_ind[22]; /* msdu_length */
>>>> +    if (msdulen > 127) {
>>> use ieee802154_is_valid_psdu_len.
>>>
>>> Also this is psdu_len, in case of monitors -> monitors will filter then
>>> minimum ACK frame length only.
>> So the reason for this is that this *is* actually msdu length and not psdu length. What's being received is an MCPS-DATA.indication, so the chip has already performed the is_valid_psdu_len check in its MAC. Truthfully this check is probably completely unnecessary, I just added it in case something gets messed up over the SPI but I've never seen it happen. Maybe it should be removed altogether, I just thought it's a simple check to perform that could easily highlight a big problem.
>>
> ah, ok. If you know what the firmware filters and what not, then
> everything is fine. I did the expierence e.g. at at86rf230 it's simple
> not documented what they filter for length at firmware side...
>
> but you know the firmware so everything fine.
>
>>>> +        dev_err(
>>>> +            &priv->spi->dev,
>>>> +            "received erroneously large msdu length!\n"
>>>> +        );
>>>> +        kfree_skb(skb);
>>>> +        return -EMSGSIZE;
>>>> +    }
>>>> +    dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
>>>> +
>>>> +    /* Populate hdr *
>>> Doing header parsing below here will not work with monitors, monitors
>>> can also receive stuff which are smaller than 29 - I don't know what's
>>> already filtered on firmware side.
>> Again the hardware MAC will have already filtered out any frames that are not valid data frames, so the header of the data indication will always be a fixed 29 bytes.
> You are sure about this? If you receiving ack frames there will no
> addressing stuff and you will parse the frame here at positions without
> length checking if it's such frame.
>
> I can understand if you saying "ack" frames will never hit the driver,
> but begin to parse frames here... I don't know exactly the "why"?
>
> 802.15.4 frame parsing is very complex and we should some one code for
> SoftMAC to do that.
So the reason for this is just the program flow. This point in the code 
will only be reached after a data frame is being indicated. The command 
id of the API command is checked to make sure it's an 
MCPS-DATA.indication and the ca8210 command API has a fixed header for 
all the data indication parameters. So if we are checking the "frame" 
here we can be certain that it is always an MCPS-DATA.indication and we 
know that the header is always a fixed 29 bytes before the payload.

>>> I see the driver doesn't implement any promiscuousmode functionality,
>>> you need to care about that if you will add support for that later.
>> When it comes to promiscuous mode, the psdu is just copied into the msdu of the data indication. So again there will be a fixed 29 byte header on the front, just the contents is meaningless (zeroed). Again this is because the specification doesn't say how promiscuous frames are to be passed out of the MAC.
>>>> +    hdr.sec.level = data_ind[29 + msdulen];
>>>> +    dev_dbg(&priv->spi->dev, "security level: %#03x\n", hdr.sec.level);
>>>> +    if (hdr.sec.level > 0) {
>>>> +        hdr.sec.key_id_mode = data_ind[30 + msdulen];
>>>> +        memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
>>>> +        hdr.sec.key_id = data_ind[39 + msdulen];
>>>> +    }
>>>> +    hdr.source.mode = data_ind[0];
>>>> +    dev_dbg(&priv->spi->dev, "srcAddrMode: %#03x\n", hdr.source.mode);
>>>> +    hdr.source.pan_id = *(u16 *)&data_ind[1];
>>>> +    dev_dbg(&priv->spi->dev, "srcPanId: %#06x\n", hdr.source.pan_id);
>>>> +    memcpy(&hdr.source.extended_addr, &data_ind[3], 8);
>>>> +    hdr.dest.mode = data_ind[11];
>>>> +    dev_dbg(&priv->spi->dev, "dstAddrMode: %#03x\n", hdr.dest.mode);
>>>> +    hdr.dest.pan_id = *(u16 *)&data_ind[12];
>>>> +    dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
>>>> +    memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
>>>> +
>>>> +    /* Fill in FC implicitly */
>>>> +    hdr.fc.type = 1; /* Data frame */
>>>> +    if (hdr.sec.level)
>>>> +        hdr.fc.security_enabled = 1;
>>>> +    else
>>>> +        hdr.fc.security_enabled = 0;
>>>> +    if (data_ind[1] != data_ind[12] || data_ind[2] != data_ind[13])
>>>> +        hdr.fc.intra_pan = 1;
>>>> +    else
>>>> +        hdr.fc.intra_pan = 0;
>>>> +    hdr.fc.dest_addr_mode = hdr.dest.mode;
>>>> +    hdr.fc.source_addr_mode = hdr.source.mode;
>>>> +
>>>> +    /* Add hdr to front of buffer */
>>>> +    hlen = ieee802154_hdr_push(skb, &hdr);
>>>> +
>>>> +    if (hlen < 0) {
>>>> +        dev_crit(&priv->spi->dev, "failed to push mac hdr onto skb!\n");
>>>> +        kfree_skb(skb);
>>>> +        return hlen;
>>>> +    }
>>>> +
>>>> +    skb_reset_mac_header(skb);
>>>> +    skb->mac_len = hlen;
>>>> +
>>>> +    /* Add <msdulen> bytes of space to the back of the buffer */
>>>> +    /* Copy msdu to skb */
>>>> +    memcpy(skb_put(skb, msdulen), &data_ind[29], msdulen);
>>>> +
>>>> +    ieee802154_rx_irqsafe(hw, skb, data_ind[23]/*LQI*/);
>>>> +    /* TODO: Set protocol & checksum? */
>>>> +    /* TODO: update statistics */
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * ca8210_net_rx() - Acts upon received SAP commands relevant to the network
>>>> + *                   driver
>>>> + * @hw:       ieee802154_hw that command was received by
>>>> + * @command:  Octet array of received command
>>>> + * @len:      length of the received command
>>>> + *
>>>> + * Called by the spi driver whenever a SAP command is received, this function
>>>> + * will ascertain whether the command is of interest to the network driver and
>>>> + * take necessary action.
>>>> + *
>>>> + * Return: 0 or linux error code
>>>> + */
>>>> +static int ca8210_net_rx(struct ieee802154_hw *hw, u8 *command, size_t len)
>>>> +{
>>>> +    struct ca8210_priv *priv = hw->priv;
>>>> +    unsigned long flags;
>>>> +    u8 status;
>>>> +
>>>> +    dev_dbg(&priv->spi->dev, "ca8210_net_rx(), CmdID = %d\n", command[0]);
>>>> +
>>>> +    if (command[0] == SPI_MCPS_DATA_INDICATION) {
>>>> +        /* Received data */
>>>> +        spin_lock_irqsave(&priv->lock, flags);
>>>> +        if (command[26] == priv->last_dsn) {
>>>> +            dev_dbg(
>>>> +                &priv->spi->dev,
>>>> +                "DSN %d resend received, ignoring...\n",
>>>> +                command[26]
>>>> +            );
>>>> +            spin_unlock_irqrestore(&priv->lock, flags);
>>>> +            return 0;
>>>> +        }
>>>> +        priv->last_dsn = command[26];
>>>> +        spin_unlock_irqrestore(&priv->lock, flags);
>>>> +        return ca8210_skb_rx(hw, len - 2, command + 2);
>>>> +    } else if (command[0] == SPI_MCPS_DATA_CONFIRM) {
>>>> +        status = command[3];
>>>> +        if (priv->async_tx_pending) {
>>>> +            return ca8210_async_xmit_complete(
>>>> +                hw,
>>>> +                command[2],
>>>> +                status
>>>> +            );
>>>> +        } else if (priv->sync_tx_pending) {
>>>> +            priv->sync_tx_pending = false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * ca8210_skb_tx() - Transmits a given socket buffer using the ca8210
>>>> + * @skb:         Socket buffer to transmit
>>>> + * @msduhandle:  Data identifier to pass to the 802.15.4 MAC
>>>> + * @priv:        Pointer to private data section of target ca8210
>>>> + *
>>>> + * Return: 0 or linux error code
>>>> + */
>>>> +static int ca8210_skb_tx(
>>>> +    struct sk_buff      *skb,
>>>> +    u8                   msduhandle,
>>>> +    struct ca8210_priv  *priv
>>>> +)
>>>> +{
>>>> +    int status;
>>>> +    struct ieee802154_hdr header = { 0 };
>>>> +    struct secspec secspec;
>>>> +    unsigned int mac_len;
>>>> +
>>>> +    dev_dbg(&priv->spi->dev, "ca8210_skb_tx() called\n");
>>>> +
>>>> +    /* Get addressing info from skb - ieee802154 layer creates a full
>>>> +     * packet
>>>> +     */
>>>> +    mac_len = ieee802154_hdr_peek_addrs(skb, &header);
>>>> +
>>> you need at least check if error occurred. Currently we support at least
>>> 3 bytes FC + SEQ is there at driver level...
>> Sorry but I'm not sure I understand what you mean, do I need to check for errors in the skb I'm being told to transmit? Over-air error checking is performed by the ca8210 with the use of a frame counter so maybe this doesn't apply to this situation?
> I want to say here, it's possible that this transmit function get's at
> least 3 bytes from userspace. Parsing addresses will fail here, because
> the header is too small -> it will transmit random data.
Ah okay I understand now, I'm assuming this is for transmitting 
acknowledgements. I'll be throwing them away since ACKs are handled by 
the hardware.

>>>> +/**
>>>> + * ca8210_xmit_sync() - Synchronously transmits a given socket buffer using the
>>>> + *                      ca8210
>>>> + * @hw:   ieee802154_hw of ca8210 to transmit from
>>>> + * @skb:  Socket buffer to transmit
>>>> + *
>>>> + * Transmits the buffer and does not return until a confirmation of the exchange
>>>> + * is received from the ca8210.
>>>> + *
>>>> + * Return: 0 or linux error code
>>>> + */
>>>> +static int ca8210_xmit_sync(struct ieee802154_hw *hw, struct sk_buff *skb)
>>>> +{
>>>> +    struct ca8210_priv *priv = hw->priv;
>>>> +    int status;
>>>> +
>>>> +    dev_dbg(&priv->spi->dev, "calling ca8210_xmit_sync()\n");
>>>> +
>>>> +    status = ca8210_skb_tx(skb, priv->nextmsduhandle++, priv);
>>>> +    if (status)
>>>> +        return status;
>>>> +
>>>> +    priv->sync_tx_pending = true;
>>>> +
>>>> +    while (priv->sync_tx_pending)
>>>> +        msleep(1);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * ca8210_xmit_async() - Asynchronously transmits a given socket buffer using
>>>> + *                       the ca8210
>>>> + * @hw:   ieee802154_hw of ca8210 to transmit from
>>>> + * @skb:  Socket buffer to transmit
>>>> + *
>>>> + * Hands the transmission of the buffer off to a workqueue and returns
>>>> + * immediately.
>>>> + *
>>>> + * Return: 0 or linux error code
>>>> + */
>>>> +static int ca8210_xmit_async(struct ieee802154_hw *hw, struct sk_buff *skb)
>>>> +{
>>>> +    struct ca8210_priv *priv = hw->priv;
>>>> +
>>>> +    dev_dbg(&priv->spi->dev, "calling ca8210_xmit_async()\n");
>>>> +
>>>> +    priv->tx_skb = skb;
>>>> +    queue_work(priv->async_tx_workqueue, &priv->async_tx_work);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>> Okay, both sync and async are here implemented for that the callbacks
>>> are never made for.
>>>
>>> The above sync function looks like an synced operation around a async
>>> operation, because you wait until it's finished.
>>>
>>> More bad, you use busy-waiting there, look for "wait_for_completion" in
>>> linux kernel.
>>>
>>> Nevertheless, the sync operation will not be used when async is defined,
>>> so sync operation is useless here.
>>>
>>> THe idea of async is that the Linux kernel doesn't do _anything_ until a
>>> tx complete irq reports "tx is done" and wake the tx queue again. This
>>> will not happen if you queue it to a workqueue again... which makes the
>>> whole stuff synced again.
>>>
>>> If we one day have MLME-OPS it needs a synced xmit functionality ->
>>> which will use xmit_async then - because we can and need transmit stuff
>>> synced. But NOT for dataplane -> dataframes, these frames should be
>>> synced completely undepended from linux kernel. The kernel doesn't wait
>>> until it's done -> hardware will report it when it's done.
>>>
>>> The issue will begin when we have synced xmit above async
>>> functionality... Then we have a workqueue above a workqueue which is bad.
>> Okay so I've probably misunderstood how the sync and async functions should be implemented, sorry about that. I am still a bit confused though.
>> Regarding async, you say I shouldn't use a workqueue, but the context is atomic right? So if I follow my transmission path directly it will call spi_sync which can sleep. Does this mean that I *have* to use spi_async() instead? That would be a shame since it will make transmission a lot more complicated because I have to perform multiple spi exchanges to read the correct length.
>>
> Yes, async is the right way to do it.
>
> What the callback of netdevice xmit_do is "send the frame out" queue
> this into a workqueue will delay it and drop the context of netdevice
> xmit_do function...
>
> You should use async in xmit_do and irq handling.
I am using async now and I think it's all working fine, I'm still using 
a workqueue for the irq handling. This is because I ran into a deadlock 
problem calling the spi_async directly in the irq handler. I have a 
mutex to protect the spi buffers and sometimes the following would 
happen: The SPI mutex is locked while a transfer is in progress then an 
IRQ is received causing the interrupt handler to wait forever for the 
mutex to be released because it can't sleep. Is it acceptable for the 
IRQ to still use a workqueue or would it be better to remove it? If so I 
can try to change the locking or remove the need for it.

Regards,
Harry
