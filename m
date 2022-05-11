Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810ECC433F5
	for <linux-wpan@archiver.kernel.org>; Wed, 11 May 2022 13:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbiEKNJ7 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 11 May 2022 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243129AbiEKNJz (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 11 May 2022 09:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CB056973D
        for <linux-wpan@vger.kernel.org>; Wed, 11 May 2022 06:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652274593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hi/JeAuE3z2ISAG/TYEpuRUDbYxZ1Oh6j1jmHrsdnag=;
        b=ZE09KGewRDnAPszcVeU2/+4EZYiI6ufRu/geut4W5Uc5biAKwFr76oHtOPx7xz0vkHvVfa
        Z+IJ5stjo+PPyeI1LZ99iKPA2+guqrzSc6Ohha/WD9V2nfsf1LoR7EUmgskbiM7G2hClpn
        a0saMx4fEu8qRdqdA6SNenTtdOVBYgU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-gs7iMW_FO8aVCLigNGpkbw-1; Wed, 11 May 2022 09:09:52 -0400
X-MC-Unique: gs7iMW_FO8aVCLigNGpkbw-1
Received: by mail-qv1-f71.google.com with SMTP id kc6-20020a056214410600b0045a97658c7dso1929600qvb.16
        for <linux-wpan@vger.kernel.org>; Wed, 11 May 2022 06:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hi/JeAuE3z2ISAG/TYEpuRUDbYxZ1Oh6j1jmHrsdnag=;
        b=a1TxNR8T742DGIiARUpL7cVelaIDM4/R5ScJWQtN7/QZ+m9hlhbc+iyLXHheWA05QQ
         2AoXN3xALMhpkeDGSwClhdWVBOXf52WSeB1/gdEgpZTR+I8HmMR9WfNqgd0CkIh31Kp5
         MkpjYRw/yNr1V4kPpN24aITvu7c7MHQz6Lq8Y+whV4NIDUvx9MTnLHyAhqDn9xql/048
         YbtFDRjWjxbx8Zah20SBCn/VFJWA+U5g4vYHvSQhPhCY9U5fkyRNSlg+uDqgX/0EwOZp
         kIJSO/EPW2JD5AGtLRTzIybrvy3bHSsss7UZn5gOPJgj/bjMEHATCJJKG1GFYVN9tsry
         p3zA==
X-Gm-Message-State: AOAM531dezcA6rF5kXs49didezGnfQo33kibg2yk0q4WvZ9L2g4YER/6
        47BzWsrZZ+gJLrr+CjBNyNCWgIDR4DNl7Kar00R9mk0XUt40RVo6JWYADwjmQ5L7SlXQllwv/j0
        aG6CpwE0lHp6zcA4hkO94uiyZ3fp1PfAN8+4mWQ==
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id g2-20020a05620a40c200b006a02b1b2b86mr19075428qko.80.1652274591618;
        Wed, 11 May 2022 06:09:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2waDQK91pYxQ5/eTCWX3IFWKTayNe7E6Z9jrM5S3s9zWpzq/aCBXwuIwoK3GX3CW6VbrEY1S8EQtlUFtHLek=
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id
 g2-20020a05620a40c200b006a02b1b2b86mr19075398qko.80.1652274591291; Wed, 11
 May 2022 06:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220427164659.106447-1-miquel.raynal@bootlin.com>
 <20220427164659.106447-7-miquel.raynal@bootlin.com> <CAK-6q+jCYDQ-rtyawz1m2Yt+ti=3d6PrhZebB=-PjcX-6L-Kdg@mail.gmail.com>
 <20220510165237.43382f42@xps13>
In-Reply-To: <20220510165237.43382f42@xps13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 11 May 2022 09:09:40 -0400
Message-ID: <CAK-6q+jeubhGah2gG1JJxfmOW=sNdMrLf+mk_a3X_r+Na=tHXg@mail.gmail.com>
Subject: Re: [PATCH wpan-next 06/11] net: mac802154: Hold the transmit queue
 when relevant
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
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

On Tue, May 10, 2022 at 10:52 AM Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
>
> Hi Alex,
>
> > > --- a/net/mac802154/tx.c
> > > +++ b/net/mac802154/tx.c
> > > @@ -106,6 +106,21 @@ ieee802154_tx(struct ieee802154_local *local, struct sk_buff *skb)
> > >         return NETDEV_TX_OK;
> > >  }
> > >
> > > +void ieee802154_hold_queue(struct ieee802154_local *local)
> > > +{
> > > +       atomic_inc(&local->phy->hold_txs);
> > > +}
> > > +
> > > +void ieee802154_release_queue(struct ieee802154_local *local)
> > > +{
> > > +       atomic_dec(&local->phy->hold_txs);
> > > +}
> > > +
> > > +bool ieee802154_queue_is_held(struct ieee802154_local *local)
> > > +{
> > > +       return atomic_read(&local->phy->hold_txs);
> > > +}
> >
> > I am not getting this, should the release_queue() function not do
> > something like:
> >
> > if (atomic_dec_and_test(hold_txs))
> >       ieee802154_wake_queue(local);
> >
> > I think we don't need the test of "ieee802154_queue_is_held()" here,
> > then we need to replace all stop_queue/wake_queue with hold and
> > release?
>
> That's actually a good idea. I've implemented it and it looks nice too.
> I'll clean this up and share a new version with:
> - The wake call checked everytime hold_txs gets decremented
> - The removal of the _queue_is_held() helper
> - _wake/stop_queue() turned static
> - _hold/release_queue() used everywhere
>

I think there is also a lock necessary for atomic inc/dec hitting zero
and the stop/wake call afterwards... ,there are also a lot of
optimization techniques to only hold the lock for hitting zero cases
in such areas. However we will see...

- Alex

