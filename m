Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4172ECAAD3
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 11:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiIELQ7 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiIELQ6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 07:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC356564F5
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 04:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662376614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7CkDoBi37xIIBmbmDv/EWj35LuvS1ueBYk+CTK6sg4s=;
        b=gs/PtYc3OY30nk82seZWbZ8irgkC8iSi2FZDXfnFjqabZYMr8VavH7RNEj4Hck6mGcCJKy
        2YnjMjuW3KW2D1LrH36VVsfndrGrtbtKWQyRRrh9s7Z8iV02qxCna2URukTA+pwumMdQUy
        Tg1QFQt3xhY5dVRasEGhcFYhddyqezU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-XBMkGIK2PF2L-5NZm5C6HQ-1; Mon, 05 Sep 2022 07:16:53 -0400
X-MC-Unique: XBMkGIK2PF2L-5NZm5C6HQ-1
Received: by mail-qk1-f199.google.com with SMTP id h8-20020a05620a284800b006b5c98f09fbso6786637qkp.21
        for <linux-wpan@vger.kernel.org>; Mon, 05 Sep 2022 04:16:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7CkDoBi37xIIBmbmDv/EWj35LuvS1ueBYk+CTK6sg4s=;
        b=vslC3aBCUbbXJgepbPPMra+0HKEUor1t15b2SEOzOmbcaXUjxF94hTk1GhzSCauY3F
         MnFfHB91H7pr4kxZ+Qz1ZD7ZRTS+A9qOPlbpptJ9Q6uVdVH1nxdFeduS+Y3/Kqe6+WYe
         R3UUjSYThtOBefdtz84X2yJPdNMxzQ0nMB+MLfGpV8e2kLMnxkmWixTe/aWq5LSIJDoO
         icKPgasDgy1sp1PTqdZ9JvT0DHrQmjcnWtsCK57b6MKJ7yG/xsS181a9cXKo/aHecgM5
         orHxtr+vx+uC5vlPC0DFYops0pJq3vtqTGaVX+GRQRF4sdm3aYAA/0w2KCKT4W7ru81U
         vU1w==
X-Gm-Message-State: ACgBeo2481J2wxFcRUkOy16rButjVyEVOCYxjhYAmq7VJsBn044DGjFH
        UeIymqPbKhEgiG3Cl6Hu1iQpBuIEUhQdUT039SyuLWnuCxQLUHbchy3zcmBXLEYJvkrsa/OTRYk
        YisNPctmRqQYLz9GpB5SqnTw1qmwhw7P3WBzAlA==
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr38169082qtx.526.1662376613137;
        Mon, 05 Sep 2022 04:16:53 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5eSvY8Dnsq/6+yhPT4KG96ZzPkPOh2cuIPZJUGXPVmCf5si2BynkvkFAhb/Y6DE+oS2ZS24XtRRA8HkC0JHyQ=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr38169068qtx.526.1662376612871; Mon, 05
 Sep 2022 04:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220905005544.994036-1-aahringo@redhat.com> <20220905052237.513e1889@xps-13>
In-Reply-To: <20220905052237.513e1889@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 5 Sep 2022 07:16:42 -0400
Message-ID: <CAK-6q+g5VgMtMsgrws9PxbZkdp2Mw0w_8F6LRe7gjMhw67Z+Xg@mail.gmail.com>
Subject: Re: [RFC wpan-next] atusb: add support for trac feature
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, Sep 4, 2022 at 11:22 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Sun,  4 Sep 2022 20:55:44 -0400:
>
> > This patch adds support for reading the trac register if atusb firmware
> > reports tx done. There is currently a feature to compare a sequence
> > number, if the payload is 1 it tells the driver only the sequence number
> > is available if it's two there is additional the trac status register as
> > payload.
> >
> > Currently the atusb_in_good() function determines if it's a tx done or
> > rx done if according the payload length. This patch is doing the same
> > and assumes this behaviour.
> >
> > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > ---
> >
> > Just an RFC, need another weekend to test it.
> >
> >  drivers/net/ieee802154/atusb.c | 33 ++++++++++++++++++++++++++++-----
> >  1 file changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> > index 2c338783893d..95a4a3cdc8a4 100644
> > --- a/drivers/net/ieee802154/atusb.c
> > +++ b/drivers/net/ieee802154/atusb.c
> > @@ -191,7 +191,7 @@ static void atusb_work_urbs(struct work_struct *work)
> >
> >  /* ----- Asynchronous USB -------------------------------------------------- */
> >
> > -static void atusb_tx_done(struct atusb *atusb, u8 seq)
> > +static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
> >  {
> >       struct usb_device *usb_dev = atusb->usb_dev;
> >       u8 expect = atusb->tx_ack_seq;
> > @@ -199,7 +199,10 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq)
> >       dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
> >       if (seq == expect) {
> >               /* TODO check for ifs handling in firmware */
> > -             ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> > +             if (reason == IEEE802154_SUCCESS)
> > +                     ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> > +             else
> > +                     ieee802154_xmit_error(atusb->hw, atusb->tx_skb, reason);
> >       } else {
> >               /* TODO I experience this case when atusb has a tx complete
> >                * irq before probing, we should fix the firmware it's an
> > @@ -215,7 +218,8 @@ static void atusb_in_good(struct urb *urb)
> >       struct usb_device *usb_dev = urb->dev;
> >       struct sk_buff *skb = urb->context;
> >       struct atusb *atusb = SKB_ATUSB(skb);
> > -     u8 len, lqi;
> > +     int result = IEEE802154_SUCCESS;
> > +     u8 len, lqi, trac;
> >
> >       if (!urb->actual_length) {
> >               dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
> > @@ -224,8 +228,27 @@ static void atusb_in_good(struct urb *urb)
> >
> >       len = *skb->data;
> >
> > -     if (urb->actual_length == 1) {
> > -             atusb_tx_done(atusb, len);
> > +     switch (urb->actual_length) {
> > +     case 2:
> > +             trac = TRAC_MASK(*(skb->data + 1));
>
> I've been fighting all night thinking the issues were on the atusb side
> (it was horribly difficult to get the atusb toolchain up and running,
> I'll send a patch to update the instructions), in particular because of

Really? for me it was just apt install avr-gcc libc-avr (or what the
debian packages name is). Then the dfu-util and be sure you invoke
dfu-util (as root because you might need some udev rules otherwise)
when the atusb is booting up.

> the data[2] definition which needed to be declared static outside of
> the functions (see the other mail) and, I guess, because of this
> beginner error: I was using skb->data[1] but of course it can't work.
>

mhh, I am sorry. I am not sure if I understand what you mean? Does the
firmware patch have issues regarding data[2]?

> Anyway, this patch works, I've tested it by:
> - associating a device (an Arduino Nano running Zephyr, btw)
> - having the atusb disassociating the nano successfully (trac = 0)
> - reassociating the nano
> - powering off the nano
> - trying to disassociate
>
> The disassociation notification transmission fails with a TRAC status
> NO_ACK. So:
>
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> I still have the filtering thing to improve, I'm not sure I'll have
> time to do that this week. I need some time to prepare the slides now
> that the demo works :)
>

ok, no problem. Thanks for testing it. I am happy that if I could help
you here a little bit.

- Alex

