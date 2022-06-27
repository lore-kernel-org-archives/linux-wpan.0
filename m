Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338EEC43334
	for <linux-wpan@archiver.kernel.org>; Mon, 27 Jun 2022 02:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiF0Cbp (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 26 Jun 2022 22:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiF0Cbp (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 26 Jun 2022 22:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D1632BEC
        for <linux-wpan@vger.kernel.org>; Sun, 26 Jun 2022 19:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656297103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NbmH8eeNH9GCNyJEMJVIoZ6jzBY1Wwznz8gCyxIKlQM=;
        b=DrjXV66dKehKrYyMP9VKK/gHV2fxQFOANue0FvsMbzaPQ0/i4hoX3NK27eON0WdAaR75IY
        V8vNHFpqncKhqMuJJBX3suBJpKsXTqTf0IaHo8vQujbnQR1G61csfm2+q6vnXEI19YfrEd
        CqmbYXGy5t0iVE15TLRZfC66bRoLXAE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-IvZado2UM7KHXM1TN6HzGA-1; Sun, 26 Jun 2022 22:31:41 -0400
X-MC-Unique: IvZado2UM7KHXM1TN6HzGA-1
Received: by mail-qv1-f71.google.com with SMTP id 10-20020a0562140cca00b004702e8ce21bso8138530qvx.22
        for <linux-wpan@vger.kernel.org>; Sun, 26 Jun 2022 19:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NbmH8eeNH9GCNyJEMJVIoZ6jzBY1Wwznz8gCyxIKlQM=;
        b=tmyO+gLkHBcPkyCrAMlAoZ7SEjujXozEkYhnGYWzqDUlD8evvZQXeoXzIHu5qAmAFw
         J8EeGH2OJ3OiFuwW65qg9WWZYHtJFFoi5cyVltNM0Nd2NHHSTw5vm0qizJfwyfkoi551
         5EpF6ZlXfQAyOXro/pT6tIbZXLjgtdeV5ULWutSiVsB4k/DmqDyDQRVJiSheP5iJYoNc
         6UCA35YXn+ZHWteFAbQCXMNdS7DmkkEc0q4cBJutfh3yKcgEa3cOgZtkoJ86tQKOWpdy
         FpeAFjeRIh1vf5wZZ/GALJA7FNz4zQZxCVLS3uRqij1DGHLbqxIoh84xOlpCaenXjRyp
         19NA==
X-Gm-Message-State: AJIora+MilX/NLLTH0uAX+IWH0et2HyoFrv34fNrU1d/b2NXPuBY/fj0
        rHwYhAq/qDtFGy9tThWDcNS7cDkEYKIywuMeLN15N4FKK/BdGXv1TlCziFblOpkl5+oTUkZ1MYH
        Z5EJmo4bgAma5uVlPJ52c6H5flWgx2FxoSkpP8A==
X-Received: by 2002:a0c:dc83:0:b0:470:aa91:9ea5 with SMTP id n3-20020a0cdc83000000b00470aa919ea5mr5787257qvk.28.1656297101021;
        Sun, 26 Jun 2022 19:31:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sckSJl+2KxDYqzywLJ6Cgs+wC5jgXtSANOYX1ODyEpm+4+KD8q/ct4paXz1mgZ94SHRCAZ8XaT/QePmQ65Nnw=
X-Received: by 2002:a0c:dc83:0:b0:470:aa91:9ea5 with SMTP id
 n3-20020a0cdc83000000b00470aa919ea5mr5787245qvk.28.1656297100859; Sun, 26 Jun
 2022 19:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
 <e3efe652-eb22-4a3f-a121-be858fe2696b@datenfreihafen.org> <CAK-6q+h7497czku9rf9E4E=up5k5gm_NT0agPU2bUZr4ADKioQ@mail.gmail.com>
 <20220616093422.2e9ec948@kernel.org>
In-Reply-To: <20220616093422.2e9ec948@kernel.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 26 Jun 2022 22:31:29 -0400
Message-ID: <CAK-6q+hvw-3EtSoQA-01w+RPCZ1mUDtPEyw-um9a6ocOzW+ovg@mail.gmail.com>
Subject: Re: 6lowpan netlink
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Thu, Jun 16, 2022 at 12:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 16 Jun 2022 09:00:08 -0400 Alexander Aring wrote:
> > > > I want to spread around that I started to work on some overdue
> > > > implementation, a netlink 6lowpan configuration interface, because
> > > > rtnetlink is not enough... it's for configuring very specific 6lowpan
> > > > device settings.
> > >
> > > Great, looking forward to it!
> >
> > I would like to trigger a discussion about rtnetlink or generic. I can
> > put a nested rtnetlink for some device specific settings but then the
> > whole iproute2 (as it's currently is) would maintain a specific
> > 6lowpan setting which maybe the user never wants...
> > I think we should follow this way when there is a strict ipv6 device
> > specific setting e.g. l2 neighbor information in ipv6 ndisc.
>
> Unless you'll have to repeat attributes which are already present
> in rtnetlink in an obvious way genetlink > rtnetlink.

I think this is not the case, I do not implement a new protocol
family... I just need to manipulate some 6lowpan stack settings that
aren't part of the current ipv6 protocol familty rtnetlink operations.

Thanks.

 - Alex

