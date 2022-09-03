Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3777C6FA83
	for <linux-wpan@archiver.kernel.org>; Sat,  3 Sep 2022 19:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiICTkx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 3 Sep 2022 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiICTkw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Sep 2022 15:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A9543CB
        for <linux-wpan@vger.kernel.org>; Sat,  3 Sep 2022 12:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662234048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=40XvrkiDplSvrDrCmOF2GWKUpOQUPdpiRHxlDL468+0=;
        b=Hgvdb6R4GsimjtZLTmEIwUX6BHL3y3oSRHzt72mP475rloyEInaSY918SvwocND2ekVzzD
        shtBg+1h6qtUaf84ZZnCW9zv6lNsEqJDhrDLpJbRnBh+XaZTJEdbTg2DpcRYLiy0zOr6vJ
        5QzqbSTfAMZUUEKsvXROG2q3F+5TnS8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-173-rqAaKpcAOzejCPDZ-xBh2w-1; Sat, 03 Sep 2022 15:40:47 -0400
X-MC-Unique: rqAaKpcAOzejCPDZ-xBh2w-1
Received: by mail-qk1-f197.google.com with SMTP id r14-20020a05620a298e00b006be796b6164so4435411qkp.19
        for <linux-wpan@vger.kernel.org>; Sat, 03 Sep 2022 12:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=40XvrkiDplSvrDrCmOF2GWKUpOQUPdpiRHxlDL468+0=;
        b=ffcaMnZyldm6uIgkd3YAhfXul+JOl6uQV3aJbdBsr9e8J5BYNa39xlCBu9Z6wW83yo
         V+VnARdGiMa+2fngl1Ps9iM5qSVqcFo6VPXpXw+2LVj5olkuelERlQ6xS+1rK9PyOkIY
         f/Feg/+342BVfvcPpArNFzJL1hIVTrqMGr7hgUX/7ZQe0dRY4GDhLhx4o7pMqaZqKL3A
         24tD3Af5ycfgcCp+O2SX5aucfgUTBge9WZsiJqskHMB3WqM0t1bdz0g3rvkibFO8ZyyS
         /d12s1aLeW+/RcLC+JdO9/euH3LUqukLZ5gFRMmeQeA1/oHuLuFHZEcuf0jGFFMkt2LQ
         LJZg==
X-Gm-Message-State: ACgBeo1W18rYC/8f6vtQ7J7rl6gvkH6WGYD7h7ogxNpdKWwm7CmJ/m+w
        PDTD4FPBq2LJM5FY6VK1qhAWqxpqc6pGlbJz5do0rp87EEYWFuMbgLqnOkTxMqtSKi0uT4y+QaP
        svEjok+hSuNtjIYCXqpGglQIR/1ZZL3YaKyQ/iw==
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id x4-20020a05622a000400b0034494b7a396mr32764652qtw.123.1662234046978;
        Sat, 03 Sep 2022 12:40:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5JfAgJx0pwj13Xjxw4kwabYxjtA6MyKyNnfGMHE+LjgLC+9Y/qJ90YRe3xVnhQ4NL0R8kjeODE3Lj8bkBuB+k=
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id
 x4-20020a05622a000400b0034494b7a396mr32764644qtw.123.1662234046781; Sat, 03
 Sep 2022 12:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220823182950.1c722e13@xps-13> <CAK-6q+jfva++dGkyX_h2zQGXnoJpiOu5+eofCto=KZ+u6KJbJA@mail.gmail.com>
 <20220824122058.1c46e09a@xps-13> <CAK-6q+gjgQ1BF-QrT01JWh+2b3oL3RU+SoxUf5t7h3Hc6R8pcg@mail.gmail.com>
 <20220824152648.4bfb9a89@xps-13> <CAK-6q+itA0C4zPAq5XGKXgCHW5znSFeB-YDMp3uB9W-kLV6WaA@mail.gmail.com>
 <20220825145831.1105cb54@xps-13> <CAK-6q+j3LMoSe_7u0WqhowdPV9KM-6g0z-+OmSumJXCZfo0CAw@mail.gmail.com>
 <20220826095408.706438c2@xps-13> <CAK-6q+gxD0TkXzUVTOiR4-DXwJrFUHKgvccOqF5QMGRjfZQwvw@mail.gmail.com>
 <20220829100214.3c6dad63@xps-13> <CAK-6q+gJwm0bhHgMVBF_pmjD9zSrxxHvNGdTrTm0fG-hAmSaUQ@mail.gmail.com>
 <20220831173903.1a980653@xps-13> <20220901020918.2a15a8f9@xps-13>
 <20220901150917.5246c2d0@xps-13> <CAK-6q+g1Gnew=zWsnW=HAcLTqFYHF+P94Q+Ywh7Rir8J8cgCgw@mail.gmail.com>
 <20220903020829.67db0af8@xps-13> <CAK-6q+hO1i=xvXx3wHo658ph93FwuVs_ssjG0=jnphEe8a+gxw@mail.gmail.com>
 <20220903180556.6430194b@xps-13> <CAK-6q+hXrUOzrsucOw3vJMu3UscOMG8X3E74px6bEZoDO4PLjw@mail.gmail.com>
 <CAK-6q+iA80oRi_NJODNkJTJmkVkcvMwO=HxRr-bPT3-u6f7iLA@mail.gmail.com>
In-Reply-To: <CAK-6q+iA80oRi_NJODNkJTJmkVkcvMwO=HxRr-bPT3-u6f7iLA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 3 Sep 2022 15:40:35 -0400
Message-ID: <CAK-6q+jiDcf_M6S+gWh_qms=dMPaSb4daPC7Afs6RZjQdHGinQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next 01/20] net: mac802154: Allow the creation of
 coordinator interfaces
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        werner@almesberger.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sat, Sep 3, 2022 at 3:10 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> On Sat, Sep 3, 2022 at 3:07 PM Alexander Aring <aahringo@redhat.com> wrote:
> >
> > Hi,
> >
> > On Sat, Sep 3, 2022 at 12:06 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > ...
> > >
> > > On the Tx side, when sending eg. an association request or an
> > > association response, I must expect and wait for an ack. This is
> > > what I am struggling to do. How can I know that a frame which I just
> > > transmitted has been acked? Bonus points, how can I do that in such a
> > > way that it will work with other devices? (hints below)
> > >
> > > > AACK will send a back if a frame with ack request bit was received.
> > > >
> > > > > say in a commit) I have seen no further updates about it so I guess
> > > > > it's still not available. I don't see any other way to know if a
> > > > > frame's ack has been received or not reliably.
> > > >
> > > > You implemented it for the at86rf230 driver (the spi one which is what
> > > > also atusb uses). You implemented the
> > > >
> > > > ctx->trac = IEEE802154_NO_ACK;
> > > >
> > > > which signals the upper layer that if the ack request bit is set, that
> > > > there was no ack.
> > > >
> > > > But yea, there is a missing feature for atusb yet which requires
> > > > firmware changes as well.
> > >
> > > :'(
> >
> > There is a sequence handling in tx done on atusb firmware and I think
> > it should be pretty easy to add a byte for trac status.
> >
> > diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
> > index 835002c..156bd95 100644
> > --- a/atusb/fw/mac.c
> > +++ b/atusb/fw/mac.c
> > @@ -116,7 +116,7 @@ static void receive_frame(void)
> >
> >  static bool handle_irq(void)
> >  {
> > -       uint8_t irq;
> > +       uint8_t irq, data[2];
> >
> >         irq = reg_read(REG_IRQ_STATUS);
> >         if (!(irq & IRQ_TRX_END))
> > @@ -124,7 +124,15 @@ static bool handle_irq(void)
> >
> >         if (txing) {
> >                 if (eps[1].state == EP_IDLE) {
> > -                       usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
> > +                       data[0] = tx_ack_done;
> > +
> > +                       spi_begin();
> > +                       spi_io(REG_TRX_STATE);
> > +
> > +                       data[1] = spi_recv();
> > +                       spi_end();
>
> data[1] = reg_read(REG_TRX_STATE) as seen above for REG_IRQ_STATUS
> would be better here...
>

after digging the code more, there is another queue case which we
should handle, also correct using buffer parameter instead of the
callback parameter which was stupid... However I think the direction
is clear. Sorry for the spam.

diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 835002c..b52ba1a 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -32,7 +32,7 @@ static uint8_t tx_buf[MAX_PSDU];
 static uint8_t tx_size = 0;
 static bool txing = 0;
 static bool queued_tx_ack = 0;
-static uint8_t next_seq, this_seq, queued_seq;
+static uint8_t next_seq, this_seq, queued_seq, queued_tx_trac;


 /* ----- Receive buffer management ----------------------------------------- */
@@ -57,6 +57,7 @@ static void tx_ack_done(void *user);
 static void usb_next(void)
 {
        const uint8_t *buf;
+       uint8_t data[2];

        if (rx_in != rx_out) {
                buf = rx_buf[rx_out];
@@ -65,7 +66,9 @@ static void usb_next(void)
        }

        if (queued_tx_ack) {
-               usb_send(&eps[1], &queued_seq, 1, tx_ack_done, NULL);
+               data[0] = queued_seq;
+               data[1] = queued_tx_trac;
+               usb_send(&eps[1], data, sizeof(data), tx_ack_done, NULL);
                queued_tx_ack = 0;
        }
 }
@@ -116,7 +119,7 @@ static void receive_frame(void)

 static bool handle_irq(void)
 {
-       uint8_t irq;
+       uint8_t irq, data[2];

        irq = reg_read(REG_IRQ_STATUS);
        if (!(irq & IRQ_TRX_END))
@@ -124,10 +127,13 @@ static bool handle_irq(void)

        if (txing) {
                if (eps[1].state == EP_IDLE) {
-                       usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
+                       data[0] = this_seq;
+                       data[1] = reg_read(REG_TRX_STATE);
+                       usb_send(&eps[1], data, sizeof(data),
tx_ack_done, NULL);
                } else {
                        queued_tx_ack = 1;
                        queued_seq = this_seq;
+                       queued_tx_trac = reg_read(REG_TRX_STATE);
                }
                txing = 0;
                return 1;

