Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C14ECAAD5
	for <linux-wpan@archiver.kernel.org>; Sat,  3 Sep 2022 19:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiICTIE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 3 Sep 2022 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiICTID (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Sep 2022 15:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A857E37
        for <linux-wpan@vger.kernel.org>; Sat,  3 Sep 2022 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662232081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eymqgh2jDvB8LA8b8NQVgPAORe5Q0xfaTbWqTmmrUn0=;
        b=YMafQp2SM4YoBb+FVyzTsEjqUCeYiMTDuBTS7r95zVdfLTdGsrpGEm+F4kDucPN68yrbhw
        335V+JWCgMX3oKwinn3IHIm6Tzz6Ma23JMjJCDSMrocv57svFwBt6BeFkETWTeqBO2ZcIH
        5V9eI9ph8AKw85FlqWpdJNRJlF7n75k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-128-zZr18eCMN6KLAi2Fpp6J7Q-1; Sat, 03 Sep 2022 15:08:00 -0400
X-MC-Unique: zZr18eCMN6KLAi2Fpp6J7Q-1
Received: by mail-qt1-f199.google.com with SMTP id bz20-20020a05622a1e9400b003436a76c6e6so3970152qtb.1
        for <linux-wpan@vger.kernel.org>; Sat, 03 Sep 2022 12:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Eymqgh2jDvB8LA8b8NQVgPAORe5Q0xfaTbWqTmmrUn0=;
        b=aONSGIUhyZ4U9a08TlmSJKpr2D+NRcGvVxev0m1is/Wp374pziNve2+pHkgA2b/Oni
         YfP+YfU1KP8S33AGeUdcabOaaeup5nv68JyZeHn6QFEfHYDEuuP6UZzSF5FdLC3MgGAX
         8t1R/3nVmL6SrBgWKs9P575PI9L36Qngi9Ipbv4DJsoPsL17F/cfXjFiZ01wM70/Za1d
         aCzKawLIA+9srr5jTuYMvfCajwXFf4lbkwXSg22aeufv8xQL0Hw+r1TmUKVpQi8Hv0XC
         ttK0r8Wxgpuh38oknVTNJeCIWHayPgBefrYWZ3q6r+DnZ/DYv2lkSeKWew1oasqvaq3V
         ajcQ==
X-Gm-Message-State: ACgBeo32u513XXdpf7RfOP4hCGjLi0Jrk0w8gdEb2otHI/vtV0NgsY9H
        VSKXTIW9PLQdfJeA1oDr2RQe3XZ8F5JuiZF/nN0Ua7PjM7dEkE5llOZlzDHoU9WyJFPsesm/kDD
        KQAC6i30hKCRacK89j58H23KzV70NbVJ7uyBiIA==
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id q13-20020a05622a04cd00b0034365a4e212mr32876697qtx.526.1662232080023;
        Sat, 03 Sep 2022 12:08:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+j98vMIaGgx7fhpGl0Zz6BiCj4skZ8E9BKpsaH9Bd75J9hFO2K9Bcr08ovXTuX36OsLXct3BtbH1kHV98RNg=
X-Received: by 2002:a05:622a:4cd:b0:343:65a4:e212 with SMTP id
 q13-20020a05622a04cd00b0034365a4e212mr32876681qtx.526.1662232079830; Sat, 03
 Sep 2022 12:07:59 -0700 (PDT)
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
 <20220903180556.6430194b@xps-13>
In-Reply-To: <20220903180556.6430194b@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 3 Sep 2022 15:07:48 -0400
Message-ID: <CAK-6q+hXrUOzrsucOw3vJMu3UscOMG8X3E74px6bEZoDO4PLjw@mail.gmail.com>
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

On Sat, Sep 3, 2022 at 12:06 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
...
>
> On the Tx side, when sending eg. an association request or an
> association response, I must expect and wait for an ack. This is
> what I am struggling to do. How can I know that a frame which I just
> transmitted has been acked? Bonus points, how can I do that in such a
> way that it will work with other devices? (hints below)
>
> > AACK will send a back if a frame with ack request bit was received.
> >
> > > say in a commit) I have seen no further updates about it so I guess
> > > it's still not available. I don't see any other way to know if a
> > > frame's ack has been received or not reliably.
> >
> > You implemented it for the at86rf230 driver (the spi one which is what
> > also atusb uses). You implemented the
> >
> > ctx->trac = IEEE802154_NO_ACK;
> >
> > which signals the upper layer that if the ack request bit is set, that
> > there was no ack.
> >
> > But yea, there is a missing feature for atusb yet which requires
> > firmware changes as well.
>
> :'(

There is a sequence handling in tx done on atusb firmware and I think
it should be pretty easy to add a byte for trac status.

diff --git a/atusb/fw/mac.c b/atusb/fw/mac.c
index 835002c..156bd95 100644
--- a/atusb/fw/mac.c
+++ b/atusb/fw/mac.c
@@ -116,7 +116,7 @@ static void receive_frame(void)

 static bool handle_irq(void)
 {
-       uint8_t irq;
+       uint8_t irq, data[2];

        irq = reg_read(REG_IRQ_STATUS);
        if (!(irq & IRQ_TRX_END))
@@ -124,7 +124,15 @@ static bool handle_irq(void)

        if (txing) {
                if (eps[1].state == EP_IDLE) {
-                       usb_send(&eps[1], &this_seq, 1, tx_ack_done, NULL);
+                       data[0] = tx_ack_done;
+
+                       spi_begin();
+                       spi_io(REG_TRX_STATE);
+
+                       data[1] = spi_recv();
+                       spi_end();
+
+                       usb_send(&eps[1], &this_seq, sizeof(data), data, NULL);
                } else {
                        queued_tx_ack = 1;
                        queued_seq = this_seq;

Did not test it, but maybe something in this direction?

cc Werner Almesberger here, he did most of the atusb hardware and firmware.

- Alex

