Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53740
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751414AbcK3Vx4 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 16:53:56 -0500
Subject: Re: [PATCH v5 1/3] ieee802154: Add CA8210 IEEE 802.15.4 device driver
References: <20161124091822.3752-1-h.morris@cascoda.com>
 <20161124091822.3752-2-h.morris@cascoda.com>
 <556dedec-fc56-1b62-300c-436f76bf7f83@osg.samsung.com>
 <c24929b6-1439-2846-e387-fcf4210fce0d@cascoda.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <f2cc6a6d-ec57-71b9-4992-e0fe05ae7400@osg.samsung.com>
Date: Wed, 30 Nov 2016 22:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <c24929b6-1439-2846-e387-fcf4210fce0d@cascoda.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: h.morris@cascoda.com
Cc: harrymorris12@gmail.com, linux-wpan@vger.kernel.org, aar@pengutronix.de, marcel@holtmann.org

Hello.

I cutted them pieces of the patch out so we do not have to carry the 
3600 lines around for each message from now on.

On 30/11/16 15:10, Harry Morris wrote:
> Hi Stefan,
>
> On 25/11/2016 14:44, Stefan Schmidt wrote:
>
>> When running this patch through scripts/checkpatch.pl I get the
>> following:
>>
>> total: 52 errors, 60 warnings, 189 checks, 3690 lines checked
>>
>> That is quite a bunch or warnings and errors. Please have a look at
>> them. Many of them are coding style related and it saves us both a lot
>> of time and re-post cycles if you go with the checkscript on your side
>> to find and fix most of them. I will drop my coding style comments
>> until this is fixed. Easier for both of us. :)
>
> Sorry about that, I ran through the script previously but I guess some
> issues have been introduced in more recent changes. I'll run through it
> again.

Thanks :)

[Snip]

>>> +
>>> +/**
>>> + * struct fulladdr - full MAC addressing information structure
>>> + * @mode:    address mode (none, short, extended)
>>> + * @pan_id:  16-bit LE pan id
>>> + * @address: LE address, variable length as specified by mode
>>> + *
>>> + */
>>
>>
>> Out of interest because I deal with something like this myself for
>> production. Does the chip has some way to store a unique extended
>> permanent address somewhere? I ask this because I know the device is
>> not a simple transceiver but also runs some firmware which could be
>> used to handling storing the address, etc. From what I have seen used
>> on the Ci40 it relies on getting the address set from userspace in
>> early network bringup.
>
> No I'm afraid the ca8210 has no non-volatile memory so cannot store the
> extended address set in the PIB. A user can read the address and store
> it somewhere off-chip of course and then write it back but the chip
> doesn't do anything like that itself.

OK, so not different to all the other transceivers at all. I just had 
hope due to the MAC firmware you might have such a feature. :)

[Snip]

>>> +
>>> +/**
>>> + * ca8210_reset_send() - Hard resets the ca8210 for a given time
>>> + * @spi:  Pointer to target ca8210 spi device
>>> + * @ms:   Milliseconds to hold the reset line low for
>>> + */
>>> +static void ca8210_reset_send(struct spi_device *spi, unsigned int ms)
>>> +{
>>> +    struct ca8210_platform_data *pdata = spi->dev.platform_data;
>>> +    struct ca8210_priv *priv = spi_get_drvdata(spi);
>>> +    unsigned long startjiffies;
>>> +
>>> +    #define RESET_OFF 0
>>> +    #define RESET_ON 1
>>
>>
>> I#m pretty sure I commented on this before. Having this define and
>> undef in function scope just for having a 0 and a 1 used once is to
>> much. Either have globale defines like #define OFF 0 and #define ON 1
>> to be used over the driver or just simply use 0 or 1. What 0 and 1
>> means is pretty clear, the magic number we do not want are things like
>> reg = 0x73 where we have no idea what they mean.
>>
>> This is true for other instances of this define undef pattern all over
>> the code.
>
> My original thinking was that to someone who didn't know that the reset
> was active-low there was a possibility for some misunderstanding. After
> looking again though I think you're right and it's fine to just have a 1
> and 0.

Good, thanks.

> Regarding the other instances I wanted some way to make things a bit
> more readable (|DATAREQ.msdu_length| vs
> |command.pdata.data_req.msdulength|) but also wanted the macro
> definition visible when looking at the function so it's clear what
> DATAREQ actually means.


Matter of taste surely. I find the long form pretty readable without 
having to refer to the macro again what it read stands for.

  Would just declaring a pointer locally be a
> better way of doing this? I just thought it's a waste of memory since
> it's constant but I guess it's totally negligible.

Having the local pointer should really not be a problem here and would 
make things a lot more comfortable. :)

[Snip]

>>> +
>>> +/**
>>> + * tdme_chipinit() - TDME Chip Register Default Initialisation Macro
>>> + * @device_ref: Nondescript pointer to target device
>>> + *
>>> + * Return: 802.15.4 status code of API calls
>>> + */
>>> +static uint8_t tdme_chipinit(void *device_ref)
>>> +{
>>> +    uint8_t status = MAC_SUCCESS;
>>> +    uint8_t sfr_address;
>>> +    struct spi_device *spi = device_ref;
>>> +
>>> +    if ((status = tdme_setsfr_request_sync(
>>> +        1, (sfr_address = CA8210_SFR_LNAGX40), 0x29, device_ref))
>>
>>
>> here, and all the examples below, we now have the kind of magic
>> numbers that tell other developers nothing when looking at the driver.
>> Having defines with a meaningful name would be much better.
>>
>
> The following are different LNA gain values in 1/4dB steps so they are
> simple values which have just been calibrated for the hardware, is it
> enough just to give them names like LNAGX41_DEFAULT_GAIN? Or maybe
> LNAGX41_21DB_GAIN? feel like any more explanation of how those values
> are derived is out of the scope of the driver and one should really be
> consulting the extended hardware documentation. I agree the numbers are
> pretty meaningless to readers but I'm not sure where to draw the line
> with firmware-related documentation.


Such names are already a step forward and enough from my view. These 
values are pretty clear to you, but you have to keep in mind that you 
have been working with this specific hardware a long time already. 
Writing drivers for different systems for it already. For newcomers 
looking at this driver even this simple names have a good value over the 
plain magic numbers.

[Snip]

>>> +static int ca8210_skb_rx(
>>> +    struct ieee802154_hw  *hw,
>>> +    size_t                 len,
>>> +    uint8_t               *data_ind
>>> +)
>>> +{
>>> +    struct ieee802154_hdr hdr;
>>> +    int msdulen;
>>> +    int hlen;
>>> +    struct sk_buff *skb;
>>> +    struct ca8210_priv *priv = hw->priv;
>>> +
>>> +    /* Allocate mtu size buffer for every rx packet */
>>> +    skb = dev_alloc_skb(IEEE802154_MTU + sizeof(hdr));
>>> +    if (skb == NULL) {
>>> +        dev_crit(&priv->spi->dev, "dev_alloc_skb failed\n");
>>> +        return -ENOMEM;
>>> +    }
>>> +    skb_reserve(skb, sizeof(hdr));
>>> +
>>> +    msdulen = data_ind[22]; /* msdu_length */
>>> +    if (msdulen > 127) {
>>> +        dev_err(
>>> +            &priv->spi->dev,
>>> +            "received erroneously large msdu length!\n"
>>> +        );
>>> +        kfree_skb(skb);
>>> +        return -EMSGSIZE;
>>> +    }
>>> +    dev_dbg(&priv->spi->dev, "skb buffer length = %d\n", msdulen);
>>> +
>>> +    /* Populate hdr */
>>> +    hdr.sec.level = data_ind[29 + msdulen];
>>> +    dev_dbg(&priv->spi->dev, "security level: %#03x\n", hdr.sec.level);
>>> +    if (hdr.sec.level > 0) {
>>> +        hdr.sec.key_id_mode = data_ind[30 + msdulen];
>>> +        memcpy(&hdr.sec.extended_src, &data_ind[31 + msdulen], 8);
>>> +        hdr.sec.key_id = data_ind[39 + msdulen];
>>> +    }
>>> +    hdr.source.mode = data_ind[0];
>>> +    dev_dbg(&priv->spi->dev, "srcAddrMode: %#03x\n", hdr.source.mode);
>>> +    hdr.source.pan_id = *(uint16_t *)&data_ind[1];
>>> +    dev_dbg(&priv->spi->dev, "srcPanId: %#06x\n", hdr.source.pan_id);
>>> +    memcpy(&hdr.source.extended_addr, &data_ind[3], 8);
>>> +    hdr.dest.mode = data_ind[11];
>>> +    dev_dbg(&priv->spi->dev, "dstAddrMode: %#03x\n", hdr.dest.mode);
>>> +    hdr.dest.pan_id = *(uint16_t *)&data_ind[12];
>>> +    dev_dbg(&priv->spi->dev, "dstPanId: %#06x\n", hdr.dest.pan_id);
>>> +    memcpy(&hdr.dest.extended_addr, &data_ind[14], 8);
>>> +
>>> +    /* Fill in FC implicitly */
>>> +    hdr.fc.type = 1; /* Data frame */
>>
>> Pretty hard core hard coding of the frame type :)
>>
>> Right now that works as we do not support beacon or mac command frames
>> and ack frames are handled on hardware level but when that changes
>> this will just break apart.
>>
>
> Yep, the whole hardmac device/softmac driver situation is not ideal, a
> conversion to a hardmac driver is what's really needed going forward. I
> mean as it stands this function is only called on receipt of an
> MCPS-DATA.indication so it /will/ always be the receipt of a data frame
> being reported but yeah it's a bit... painful

:D

As you have been running into all these problems it would be great if 
you could scribble them down as some notes. Based on that we can start 
discussion what needs to be done in the stack to support hardMAC devices 
better. Having the notes of someone who already worked around things 
would be really useful. Nothing we need to discuss here and now but 
after the driver is in that would become interesting.


>>
>>> +    if (hdr.sec.level)
>>> +        hdr.fc.security_enabled = 1;
>>> +    else
>>> +        hdr.fc.security_enabled = 0;
>>> +    if (data_ind[1] != data_ind[12] || data_ind[2] != data_ind[13])
>>> +        hdr.fc.intra_pan = 1;
>>> +    else
>>> +        hdr.fc.intra_pan = 0;
>>> +    hdr.fc.dest_addr_mode = hdr.dest.mode;
>>> +    hdr.fc.source_addr_mode = hdr.source.mode;
>>> +
>>> +    /* Add hdr to front of buffer */
>>> +    hlen = ieee802154_hdr_push(skb, &hdr);
>>> +
>>> +    if (hlen < 0) {
>>> +        dev_crit(&priv->spi->dev, "failed to push mac hdr onto
>>> skb!\n");
>>> +        kfree_skb(skb);
>>> +        return hlen;
>>> +    }
>>> +
>>> +    skb_reset_mac_header(skb);
>>> +    skb->mac_len = hlen;
>>> +
>>> +    /* Add <msdulen> bytes of space to the back of the buffer */
>>> +    /* Copy msdu to skb */
>>> +    memcpy(skb_put(skb, msdulen), &data_ind[29], msdulen);
>>> +
>>> +    ieee802154_rx_irqsafe(hw, skb, data_ind[23]/*LQI*/);
>>> +    /* TODO: Set protocol & checksum? */
>>> +    /* TODO: update statistics */
>>
>> I hope that you will come to this TODOs at some point and they are not
>> going to stay in the driver forever after initial submission. No bad
>> feelings but I have seen this very often thus I give a bit more
>> pressure on the initial set of patches. :)
>
> Sorry I think it's actually more the case that those TODOs shouldn't be
> there. They were really a reminder for myself to check out whether or
> not they're needed but the IEEE802154_HW_OMIT_CHECKSUM flag removes the
> need for that and my understanding is that the statistics are handled
> further up the stack. I'll get rid of them.

Even better :)

[Snip]

>>> +static int ca8210_set_channel(
>>> +    struct ieee802154_hw  *hw,
>>> +    uint8_t                page,
>>> +    uint8_t                channel
>>> +)
>>> +{
>>> +    uint8_t status;
>>> +    struct ca8210_priv *priv = hw->priv;
>>> +
>>> +    status = mlme_set_request_sync(
>>> +        PHY_CURRENT_CHANNEL,
>>> +        0,
>>> +        1,
>>> +        &channel,
>>> +        priv->spi
>>> +    );
>>
>>
>> Thmlme commands figures out the page the channel is on on the channel
>> number alone?
>
> The channel page is stored in a separate PIB attribute phyCurrentPage
> which since the CA8210 supports only a 2.4GHz O-QPSK PHY is read-only as
> 0. I guess there should be some check of the channel page and the
> function should fail if !=0? I'm not sure if that makes sense in the
> spec actually.

Nah, sorry, I forgot that the hardware only supports channels which are 
implicitly on page 0. Since we added support for newer specs or and more 
frequencies and pages within the stack. In you case its fine to keep it 
like this. Maybe adding a comment why the page is always 0 in your case, 
not sure if this is really worth it though.

[Snip]

>>> +static const struct ieee802154_ops ca8210_phy_ops = {
>>> +    .start = ca8210_start,
>>> +    .stop = ca8210_stop,
>>> +    .xmit_sync = ca8210_xmit_sync,
>>> +    .xmit_async = ca8210_xmit_async,
>>> +    .ed = ca8210_get_ed,
>>> +    .set_channel = ca8210_set_channel,
>>> +    .set_hw_addr_filt = ca8210_set_hw_addr_filt,
>>> +    .set_txpower = ca8210_set_tx_power,
>>> +    .set_cca_mode = ca8210_set_cca_mode,
>>> +    .set_cca_ed_level = ca8210_set_cca_ed_level,
>>> +    .set_csma_params = ca8210_set_csma_params,
>>> +    .set_frame_retries = ca8210_set_frame_retries
>>
>>
>> I miss the .set_promiscuous_mode function here. Any plans to support
>> this?
>
> The problem with promiscuous mode is again related to the fact that the
> ca8210 actually has a hardmac and the fact that the spec doesn't
> actually define a way of passing promiscuous frames out of the MAC. So a
> received PSDU skips frame-filtering, okay, but how does that frame then
> get communicated above the MAC? The frame was not anticipated so there's
> no direct translation to a SAP command. In the ca8210 we just put the
> contents of the PSDU into the MSDU parameter of an MCPS-DATA.indication
> with the other parameters set to 0. This works just fine but then the
> way the frame is extracted/constructed for the stack changes. I decided
> that it wasn't worth supporting promiscuous mode for this
> implementation, at least not for the time being.

OK, I see. This is not needed for the initial submission. We can work 
out a way to get this supported after the driver was merged .

[Snip]

>>> +static int ca8210_remove(struct spi_device *spi_device)
>>> +{
>>> +    struct ca8210_priv *priv;
>>> +    struct ca8210_platform_data *pdata;
>>> +
>>> +    dev_info(&spi_device->dev, "Removing ca8210\n");
>>> +
>>> +    pdata = spi_device->dev.platform_data;
>>> +    if (pdata) {
>>> +        if (pdata->extclockenable) {
>>> +            ca8210_unregister_ext_clock(spi_device);
>>> +            ca8210_config_extern_clk(pdata, spi_device, 0);
>>> +        }
>>> +        free_irq(pdata->irq_id, spi_device->dev.driver_data);
>>> +        kfree(pdata);
>>> +        spi_device->dev.platform_data = NULL;
>>> +    }
>>> +    /* get spi_device private data */
>>> +    priv = spi_get_drvdata(spi_device);
>>> +    if (priv) {
>>> +        dev_info(
>>> +            &spi_device->dev,
>>> +            "sync_down = %d, sync_up = %d\n",
>>> +            priv->sync_down,
>>> +            priv->sync_up
>>> +        );
>>> +        ca8210_dev_com_clear(spi_device->dev.driver_data);
>>> +        if (priv->hw) {
>>> +            if (priv->hw_registered) {
>>> +                ieee802154_unregister_hw(priv->hw);
>>> +            }
>>> +            ieee802154_free_hw(priv->hw);
>>> +            priv->hw = NULL;
>>> +            dev_info(
>>> +                &spi_device->dev,
>>> +                "Unregistered & freed ieee802154_hw.\n"
>>> +            );
>>> +        }
>>> +        ca8210_test_interface_clear(priv);
>>
>>
>> Are you sure that it is save to remove the test interface even if the
>> DEBUG_FS option is not set. It should not have been created in that
>> case. You do not check for the KCONFIG option here while you do when
>> creating.
>
> Nope you're absolutely right, just an oversight on my part, thanks for
> spotting that.


No problem, thats what reviews are for.

[Snip]

>> regards
>> Stefan Schmidt
>>
>
> Thanks for picking up on all this, I'll start making changes.

Great. With the comments from above and the warnings and errors for 
CheckPatch fixed I should be satisfied and we should finally be really 
close in getting this merged. Thanks for keeping up the work on this. 
The initial submission of such a large drivers is always a bit lengthy. 
It will get better for upcoming enhancements and fixes. :)

regards
Stefan Schmidt
