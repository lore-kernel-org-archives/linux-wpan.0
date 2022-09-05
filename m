Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B86ECAAD3
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 14:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbiIEOUF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 10:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbiIEOUB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 10:20:01 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A8727169
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 07:19:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 85F3B1BF20B;
        Mon,  5 Sep 2022 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662387592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRoWZmZnziDB4SDAiyi25+wi68MDbDsfiN8dcs4O0lQ=;
        b=Wyo8uKldBAVd9WYoXrYsmRjhAF1eP2HeeZP/ka83dB8U1d0xQWpT0ejP0yHydWv/tRjgfp
        1s344bVWL5OEcADRz/jaUdpwsmu/kXjWaR13jgRNf45iSmJ9eL9xQPyTNduaXX7vDj+YEe
        BZbaS2iq6IW/NJ0fCIS+jXCHdcACRQ1IE5tmI0wNnT4zW5EepZ1bGybbrlwUKF/atAwGEO
        XlSIoGL76ygTm0KHlIhHblNn4DH+R+lf1hasC6p95ftyTUZM4S9M2HiZyFe/4S22qXQFz9
        ptxxYItG8jXg1M+oc+2CUa8+NtzPJf0cJrnztvEcx4Zl31Qgws2mks/FwbvJnA==
Date:   Mon, 5 Sep 2022 16:19:51 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Subject: Re: [RFC wpan-next] atusb: add support for trac feature
Message-ID: <20220905161951.6d439994@xps-13>
In-Reply-To: <CAK-6q+g5VgMtMsgrws9PxbZkdp2Mw0w_8F6LRe7gjMhw67Z+Xg@mail.gmail.com>
References: <20220905005544.994036-1-aahringo@redhat.com>
        <20220905052237.513e1889@xps-13>
        <CAK-6q+g5VgMtMsgrws9PxbZkdp2Mw0w_8F6LRe7gjMhw67Z+Xg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Alexander,

aahringo@redhat.com wrote on Mon, 5 Sep 2022 07:16:42 -0400:

> Hi,
>=20
> On Sun, Sep 4, 2022 at 11:22 PM Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
> >
> > Hi Alexander,
> >
> > aahringo@redhat.com wrote on Sun,  4 Sep 2022 20:55:44 -0400:
> > =20
> > > This patch adds support for reading the trac register if atusb firmwa=
re
> > > reports tx done. There is currently a feature to compare a sequence
> > > number, if the payload is 1 it tells the driver only the sequence num=
ber
> > > is available if it's two there is additional the trac status register=
 as
> > > payload.
> > >
> > > Currently the atusb_in_good() function determines if it's a tx done or
> > > rx done if according the payload length. This patch is doing the same
> > > and assumes this behaviour.
> > >
> > > Signed-off-by: Alexander Aring <aahringo@redhat.com>
> > > ---
> > >
> > > Just an RFC, need another weekend to test it.
> > >
> > >  drivers/net/ieee802154/atusb.c | 33 ++++++++++++++++++++++++++++-----
> > >  1 file changed, 28 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/net/ieee802154/atusb.c b/drivers/net/ieee802154/=
atusb.c
> > > index 2c338783893d..95a4a3cdc8a4 100644
> > > --- a/drivers/net/ieee802154/atusb.c
> > > +++ b/drivers/net/ieee802154/atusb.c
> > > @@ -191,7 +191,7 @@ static void atusb_work_urbs(struct work_struct *w=
ork)
> > >
> > >  /* ----- Asynchronous USB ------------------------------------------=
-------- */
> > >
> > > -static void atusb_tx_done(struct atusb *atusb, u8 seq)
> > > +static void atusb_tx_done(struct atusb *atusb, u8 seq, int reason)
> > >  {
> > >       struct usb_device *usb_dev =3D atusb->usb_dev;
> > >       u8 expect =3D atusb->tx_ack_seq;
> > > @@ -199,7 +199,10 @@ static void atusb_tx_done(struct atusb *atusb, u=
8 seq)
> > >       dev_dbg(&usb_dev->dev, "%s (0x%02x/0x%02x)\n", __func__, seq, e=
xpect);
> > >       if (seq =3D=3D expect) {
> > >               /* TODO check for ifs handling in firmware */
> > > -             ieee802154_xmit_complete(atusb->hw, atusb->tx_skb, fals=
e);
> > > +             if (reason =3D=3D IEEE802154_SUCCESS)
> > > +                     ieee802154_xmit_complete(atusb->hw, atusb->tx_s=
kb, false);
> > > +             else
> > > +                     ieee802154_xmit_error(atusb->hw, atusb->tx_skb,=
 reason);
> > >       } else {
> > >               /* TODO I experience this case when atusb has a tx comp=
lete
> > >                * irq before probing, we should fix the firmware it's =
an
> > > @@ -215,7 +218,8 @@ static void atusb_in_good(struct urb *urb)
> > >       struct usb_device *usb_dev =3D urb->dev;
> > >       struct sk_buff *skb =3D urb->context;
> > >       struct atusb *atusb =3D SKB_ATUSB(skb);
> > > -     u8 len, lqi;
> > > +     int result =3D IEEE802154_SUCCESS;
> > > +     u8 len, lqi, trac;
> > >
> > >       if (!urb->actual_length) {
> > >               dev_dbg(&usb_dev->dev, "atusb_in: zero-sized URB ?\n");
> > > @@ -224,8 +228,27 @@ static void atusb_in_good(struct urb *urb)
> > >
> > >       len =3D *skb->data;
> > >
> > > -     if (urb->actual_length =3D=3D 1) {
> > > -             atusb_tx_done(atusb, len);
> > > +     switch (urb->actual_length) {
> > > +     case 2:
> > > +             trac =3D TRAC_MASK(*(skb->data + 1)); =20
> >
> > I've been fighting all night thinking the issues were on the atusb side
> > (it was horribly difficult to get the atusb toolchain up and running,
> > I'll send a patch to update the instructions), in particular because of=
 =20
>=20
> Really? for me it was just apt install avr-gcc libc-avr (or what the
> debian packages name is).

I feel so bad. All the instructions I could find (from 2011) advised to
download an old gcc, an old binutils and old avr-lib, to compile
everything by hand... 2 out of 3 archives returned a 404 error, the
builds were chaotic I had to disable -Werror and fix many issues
manually, then I had to fight with binutils assembler failing, I tried
4 different versions before I got it right... I did write a commit to
update the instructions but if you say that just downloading the stock
pre-compiled binaries worked I am a bit disappointed because the
instructions specifically told not to do so.

> Then the dfu-util and be sure you invoke
> dfu-util (as root because you might need some udev rules otherwise)
> when the atusb is booting up.

Yes, dfu worked right away, very nice tool.

> > the data[2] definition which needed to be declared static outside of
> > the functions (see the other mail) and, I guess, because of this
> > beginner error: I was using skb->data[1] but of course it can't work.
> > =20
>=20
> mhh, I am sorry. I am not sure if I understand what you mean? Does the
> firmware patch have issues regarding data[2]?

Actually I'm wrong.
You did: *(skb->data + 1), which works.
I did: skb->data[1], which does not.
I thought that my mistake was related to data being a void *, but it's
a char * so both should work. I don't know why it failed, maybe my
attention level was too low and I missed something else.

> > Anyway, this patch works, I've tested it by:
> > - associating a device (an Arduino Nano running Zephyr, btw)
> > - having the atusb disassociating the nano successfully (trac =3D 0)
> > - reassociating the nano
> > - powering off the nano
> > - trying to disassociate
> >
> > The disassociation notification transmission fails with a TRAC status
> > NO_ACK. So:
> >
> > Tested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > I still have the filtering thing to improve, I'm not sure I'll have
> > time to do that this week. I need some time to prepare the slides now
> > that the demo works :)
> > =20
>=20
> ok, no problem. Thanks for testing it. I am happy that if I could help
> you here a little bit.
>=20
> - Alex
>=20


Thanks,
Miqu=C3=A8l
