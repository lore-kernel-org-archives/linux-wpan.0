Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5279FC433EF
	for <linux-wpan@archiver.kernel.org>; Tue, 17 May 2022 13:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbiEQNTq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbiEQNTo (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 09:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7545F41FAA
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652793582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byy4rNagdcXLWgiApX0leSlxdl79VV61hw0Ykw1jqds=;
        b=iTGE4iy4bvaQ9Sga5BvcKBO2ipEO6jlh0/PQM8V8HAbDOddA7EVcOHMvBQYOZqURFzeK3V
        kZo8QhoR8wSB8d3fJNUnvYY7iRY2fkzeIDu8w1LDaEQuB+wKYD0BpGijfDz9CT8aOd4d1p
        jlK6TXVhClaTBqEq/hb2YopRxVMw/Nc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-Y8tJMDKoPVGVKubeN3pHQQ-1; Tue, 17 May 2022 09:19:41 -0400
X-MC-Unique: Y8tJMDKoPVGVKubeN3pHQQ-1
Received: by mail-qt1-f199.google.com with SMTP id d13-20020ac85acd000000b002f3be21793dso13789219qtd.12
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 06:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=byy4rNagdcXLWgiApX0leSlxdl79VV61hw0Ykw1jqds=;
        b=XYX3H2M3FKL/6fbAR1+gBb+KH9ZQRaMlGG+N4fIgnwS+DXOOivD88ODCZfqJADQ/Yx
         ETg1yyaQlC9Ox4+dgjKPGrqi9CI83WIEkgG3CZ+7dWtLJuVWDbHqzV2mWAbCp9xCVuEX
         hVXyaOMnBebXr8sThOzbRjMvncjWPcDVJnlee5QE2SIFhqcDoBdt6FRRkAkFSMnmZty8
         WIT6qknAnyZIkwQni7RUqKPmZ0iJAhi2eUh46HNwvW/Cy/twYqwx+Nt0awshKzOn1qAw
         6DpNADRbu4cuy3eVfUlOFH55lKimaX1lxb5l0Scjf1sql/RSkBltOw0dQyB9wTLzQsi5
         kVIQ==
X-Gm-Message-State: AOAM531wv6mmCr9uFjeiiVXtkGPDeGcfOHIoSdqghXUsxYlazNr5huOa
        M525fgKreartg7WcNgEwTK1tNBuHZSXpj5GkUHvWMD/EcPdNYjUXzLwDphxpshdmB2m7d/Yo805
        0KtuZmo2mv4UlTBY3i++kwlBQUz7tOTson8juiA==
X-Received: by 2002:a37:cd7:0:b0:69f:9cb9:603a with SMTP id 206-20020a370cd7000000b0069f9cb9603amr16122123qkm.177.1652793580680;
        Tue, 17 May 2022 06:19:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmgn7QGLtpfDJfS0f1M8fxJBXGGOuDsrAHNm32/2hHt0Gstz3sGYueKQ9Swor4LKZo2uGE+mtFm9/2ZEzL1wk=
X-Received: by 2002:a37:cd7:0:b0:69f:9cb9:603a with SMTP id
 206-20020a370cd7000000b0069f9cb9603amr16122104qkm.177.1652793580474; Tue, 17
 May 2022 06:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220512143314.235604-1-miquel.raynal@bootlin.com>
 <20220512143314.235604-6-miquel.raynal@bootlin.com> <CAB_54W605SGbkNHhOLG5WEKsvccUvJ=rBnHErcyrte8_H=rY+g@mail.gmail.com>
 <20220517112726.4b89e907@xps-13>
In-Reply-To: <20220517112726.4b89e907@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 09:19:29 -0400
Message-ID: <CAK-6q+ihfOSBjpw1Q-2qesd4nkrAfw_rBCd0QcWzXk0PP9Prtg@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 05/11] net: mac802154: Bring the hability to
 hold the transmit queue
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, May 17, 2022 at 5:28 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alex,
>
> > > @@ -84,7 +118,7 @@ void ieee802154_xmit_complete(struct ieee802154_hw *hw, struct sk_buff *skb,
> > >                                       hw->phy->sifs_period * NSEC_PER_USEC,
> > >                                       HRTIMER_MODE_REL);
> > >         } else {
> > > -               ieee802154_wake_queue(hw);
> > > +               ieee802154_release_queue(local);
> > >         }
> > >
> > >         dev_consume_skb_any(skb);
> > > @@ -98,7 +132,7 @@ void ieee802154_xmit_error(struct ieee802154_hw *hw, struct sk_buff *skb,
> > >         struct ieee802154_local *local = hw_to_local(hw);
> > >
> > >         local->tx_result = reason;
> > > -       ieee802154_wake_queue(hw);
> > > +       ieee802154_release_queue(local);
> > >         dev_kfree_skb_any(skb);
> > >         atomic_dec(&hw->phy->ongoing_txs);
> >
> > I am pretty sure that will end in a scheduling while atomic warning
> > with hwsim. If you don't hit it you have the wrong config, you need to
> > enable such warnings and have the right preemption model setting.
>
> I was using the "desktop" kernel preemption model (voluntary), I've
> switched to CONFIG_PREEMPT ("Preemptible kernel (Low-latency)"),
> and enabled CONFIG_DEBUG_ATOMIC_SLEEP. You are right that we should use
> a spinlock instead of a mutex here. However I don't think disabling
> IRQs is necessary, so I'll switch to spin_(un)lock() calls.
>

In my opinion it's necessary for the ifs hrtimer. Normal
spin_lock/unlock is not the right fit here.

- Alex

