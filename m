Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818AC6FA8C
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 23:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232642AbiIEXKa (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 19:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiIEXKW (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 19:10:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2D24957
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 16:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662419416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0npZnIK/J+p4/lIu59x+wBjjcEQWf7CJFTbKkIKyWXQ=;
        b=c2J+bkWUlpf2jnloyHEI47BWzJ0/w4W98UpJYsTifV8qPIKwI8jL70R+GF1MDIZOScp2eS
        5fctYxqa2Rq6QGpXJFUH/ruJa7wr3c0hKmA8q3OXWk5y3NfV4CVCjmxjW/jNU/ZfW2JsbV
        emUCDnvUmgol8ZhaztaS8IMd+emrc7c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-472-FasKDZGfMmOhrtQt7oKjvw-1; Mon, 05 Sep 2022 19:10:15 -0400
X-MC-Unique: FasKDZGfMmOhrtQt7oKjvw-1
Received: by mail-qv1-f69.google.com with SMTP id k10-20020ad4450a000000b004aa116eebe8so1172184qvu.5
        for <linux-wpan@vger.kernel.org>; Mon, 05 Sep 2022 16:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0npZnIK/J+p4/lIu59x+wBjjcEQWf7CJFTbKkIKyWXQ=;
        b=lt2lnAelZKKg7UTbhoPZacUDfHjiwm/BFk9iC/v8yuStSaTkzJPYCuf6Cnazac+dU8
         xWMV7hj91ILFBXJhSQZTmrTnKpXkKhBuSc1PQR3ph/UpMBosvr7O+CmagslpU+6SQ+Nc
         LIAnoS9waewmpI0MQF4B721LVeEmbjKtD8D1XOQ58aG9cJ/Hg2ZXrqKPte1picIiysMZ
         nSZZJWglWjSaB6A/vsC02chmErNqCjSLzYUauJLIFEPNXwSVQWw/nwc8xJ6A7TDiDQSh
         VAdgZ/7q1tiQYlTWrwTKxzkhpGQYF6U0nUU1KU8kI7rczRpNGzWKiiqlvFCH8M8eJB1c
         1qMg==
X-Gm-Message-State: ACgBeo1vSuQnldy+VCA6zyVt4BgOv6Iscbhxb1OXRgr1hol6cgsYoJhf
        2j/UWkKdWqOYL9bgUChAeqFpVh6Y/byDWGYpQi+g9/Bc93f3iNPlMeILzxiukiVfMqeXA5wDtHT
        7iD5p+WaA5mDGUFVQ/pSVLdd308ycMYa/gPHBFQ==
X-Received: by 2002:a05:6214:23c7:b0:492:2ada:11d7 with SMTP id hr7-20020a05621423c700b004922ada11d7mr41232538qvb.116.1662419415095;
        Mon, 05 Sep 2022 16:10:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5g1xv4CgOvdwVK4XYdl2TY3HD/YxgSqnzRoMaGqFOer8MdCe4J15y7PqZLBcs4nO7aNtnchY5PcmOcKP+OH7k=
X-Received: by 2002:a05:6214:23c7:b0:492:2ada:11d7 with SMTP id
 hr7-20020a05621423c700b004922ada11d7mr41232506qvb.116.1662419414704; Mon, 05
 Sep 2022 16:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220905005544.994036-1-aahringo@redhat.com> <20220905052237.513e1889@xps-13>
 <CAK-6q+g5VgMtMsgrws9PxbZkdp2Mw0w_8F6LRe7gjMhw67Z+Xg@mail.gmail.com> <20220905161951.6d439994@xps-13>
In-Reply-To: <20220905161951.6d439994@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 5 Sep 2022 19:10:03 -0400
Message-ID: <CAK-6q+jmuwxEDb9r-jmrZ+gZ5XXUkV1j22D0FBuxMzU5iJyUbw@mail.gmail.com>
Subject: Re: [RFC wpan-next] atusb: add support for trac feature
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Sep 5, 2022 at 10:19 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Mon, 5 Sep 2022 07:16:42 -0400:
>
> > Hi,
> >
> > On Sun, Sep 4, 2022 at 11:22 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Sun,  4 Sep 2022 20:55:44 -0400:
> > >
> > > > This patch adds support for reading the trac register if atusb firmware
> > > > reports tx done. There is currently a feature to compare a sequence
> > > > number, if the payload is 1 it tells the driver only the sequence number
> > > > is available if it's two there is additional the trac status register as
> > > > payload.
> > > >
> > > > Currently the atusb_in_good() function determines if it's a tx done or
> > > > rx done if according the payload length. This patch is doing the same
> > > > and assumes this behaviour.
> > > >
> > > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > > ---
> > > >
> > > > Just an RFC, need another weekend to test it.
> > > >
> > > >  drivers/net/ieee802154/atusb.c | 33 ++++++++++++++++++++++++++++-----
> > > >  1 file changed, 28 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/atusb.c
> > > > index 2c338783893d..95a4a3cdc8a4 100644
> > > > --- a/drivers/net/ieee802154/atusb.c
> > > > +++ b/drivers/net/ieee802154/atusb.c
> > > > @@ -191,7 +191,7 @@ static void atusb_work_urbs(struct work_struct *work)
> > > >
> > > >  /* ----- Asynchronous USB -------------------------------------------------- */
> > > >
> > > > -static void atusb_tx_done(struct atusb *atusb, u8 seq)
> > > > +static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
> > > >  {
> > > >       struct usb_device *usb_dev = atusb->usb_dev;
> > > >       u8 expect = atusb->tx_ack_seq;
> > > > @@ -199,7 +199,10 @@ static void atusb_tx_done(struct atusb *atusb, u8 seq)
> > > >       dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, expect);
> > > >       if (seq == expect) {
> > > >               /* TODO check for ifs handling in firmware */
> > > > -             ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> > > > +             if (reason == IEEE802154_SUCCESS)
> > > > +                     ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, false);
> > > > +             else
> > > > +                     ieee802154_xmit_error(atusb->hw, atusb->tx_skb, reason);
> > > >       } else {
> > > >               /* TODO I experience this case when atusb has a tx complete
> > > >                * irq before probing, we should fix the firmware it's an
> > > > @@ -215,7 +218,8 @@ static void atusb_in_good(struct urb *urb)
> > > >       struct usb_device *usb_dev = urb->dev;
> > > >       struct sk_buff *skb = urb->context;
> > > >       struct atusb *atusb = SKB_ATUSB(skb);
> > > > -     u8 len, lqi;
> > > > +     int result = IEEE802154_SUCCESS;
> > > > +     u8 len, lqi, trac;
> > > >
> > > >       if (!urb->actual_length) {
> > > >               dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
> > > > @@ -224,8 +228,27 @@ static void atusb_in_good(struct urb *urb)
> > > >
> > > >       len = *skb->data;
> > > >
> > > > -     if (urb->actual_length == 1) {
> > > > -             atusb_tx_done(atusb, len);
> > > > +     switch (urb->actual_length) {
> > > > +     case 2:
> > > > +             trac = TRAC_MASK(*(skb->data + 1));
> > >
> > > I've been fighting all night thinking the issues were on the atusb side
> > > (it was horribly difficult to get the atusb toolchain up and running,
> > > I'll send a patch to update the instructions), in particular because of
> >
> > Really? for me it was just apt install avr-gcc libc-avr (or what the
> > debian packages name is).
>
> I feel so bad. All the instructions I could find (from 2011) advised to
> download an old gcc, an old binutils and old avr-lib, to compile
> everything by hand... 2 out of 3 archives returned a 404 error, the
> builds were chaotic I had to disable -Werror and fix many issues
> manually, then I had to fight with binutils assembler failing, I tried
> 4 different versions before I got it right... I did write a commit to
> update the instructions but if you say that just downloading the stock
> pre-compiled binaries worked I am a bit disappointed because the
> instructions specifically told not to do so.
>

I am sorry that you had those problems.

> > Then the dfu-util and be sure you invoke
> > dfu-util (as root because you might need some udev rules otherwise)
> > when the atusb is booting up.
>
> Yes, dfu worked right away, very nice tool.
>
> > > the data[2] definition which needed to be declared static outside of
> > > the functions (see the other mail) and, I guess, because of this
> > > beginner error: I was using skb->data[1] but of course it can't work.
> > >
> >
> > mhh, I am sorry. I am not sure if I understand what you mean? Does the
> > firmware patch have issues regarding data[2]?
>
> Actually I'm wrong.
> You did: *(skb->data + 1), which works.
> I did: skb->data[1], which does not.
> I thought that my mistake was related to data being a void *, but it's
> a char * so both should work. I don't know why it failed, maybe my
> attention level was too low and I missed something else.

I don't see a difference. No idea...

- Alex

