Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE04C433EF
	for <linux-wpan@archiver.kernel.org>; Tue, 17 May 2022 19:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352789AbiEQTdW (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 17 May 2022 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352796AbiEQTdS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 17 May 2022 15:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65DD1522DB
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 12:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652815995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1sB48ou7sq4iG5odbW5UgPnDZdHq+eVYauDlKBiRrs=;
        b=S463gJCBWFlvOXD5DmJehN0IxcF2rgSDzJByhhg0VPsfxkq4iZaJVTuE+k9HgLy5DAJaYg
        Al/FB5np77IXpON5MDaYZxLRAlSpCoSORPQltRuGQvtXcq7d7DpfWZYMK5oBmixIIUR5sv
        /bYZ1F1rnfGxKQtgTAGmPzvbNVINxRg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-VB5sJrt2Oya2lm785YDk9Q-1; Tue, 17 May 2022 15:33:14 -0400
X-MC-Unique: VB5sJrt2Oya2lm785YDk9Q-1
Received: by mail-qv1-f72.google.com with SMTP id t10-20020a0cd40a000000b00461c0375015so7561016qvh.0
        for <linux-wpan@vger.kernel.org>; Tue, 17 May 2022 12:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1sB48ou7sq4iG5odbW5UgPnDZdHq+eVYauDlKBiRrs=;
        b=JIEpzWQbJm2B35KtN8eqWp+iMw7XDXjvson0aLzBxHK26uC6UJv9ZYo2l/lqFMaS3l
         AvUIQDx+eOwGYvQYonqQKLSpTitFDQfTMJdK99oGy3jWW2as1KFioPgj8zHXXkM5KOCV
         JdITnCCjxJJe0lG+rXuw2p2EXbG3smRejjJuLni2h8/3B9Cn3VHG6Bki2LwQ4MZMx/ou
         AgeN6AmqFH0JBHGK5uw3CZk3yMP8jGmcVotQvLmeZSV4p0Yk5/s/w3NiiMmRT0hXLGEo
         qOn+uVJK490DasTQAIPUO/PR4J0jgS/fNLtXK9NmAA80Gv1maaqvctiNzxYFIiq2Ze0+
         v8Ag==
X-Gm-Message-State: AOAM531468DsbEU/3UAnrl+HM0xgwG/KHzSqk2HZj+An8lMgueZYtVMN
        FOXZgLl0jgFhwH3Gcv2iK62p5E6vXTtjg29vhAdwIhWBxbO6jyRZur99lCq9jcVQb0D3L7WIvcp
        uy+AtukZoAYSskOfdk6zcACJ/8vu2yfoOSabtFw==
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id g2-20020a05620a40c200b006a02b1b2b86mr17543576qko.80.1652815993397;
        Tue, 17 May 2022 12:33:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyErJA1QMczBYTs9gR2mpRT35GolnnXP55O3949L3bTONuRk5dupXTRdiVJjTkve0f85GDa08PrMhPUDoaknLI=
X-Received: by 2002:a05:620a:40c2:b0:6a0:2b1b:2b86 with SMTP id
 g2-20020a05620a40c200b006a02b1b2b86mr17543569qko.80.1652815993241; Tue, 17
 May 2022 12:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220516215638.1787257-1-kuba@kernel.org> <8e9f1b04-d17b-2812-22bb-e62b5560aa6e@gmail.com>
In-Reply-To: <8e9f1b04-d17b-2812-22bb-e62b5560aa6e@gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 17 May 2022 15:33:02 -0400
Message-ID: <CAK-6q+jRDMDGbNS2JkTXmW2dp6D7mGzZ6ghrjf7m-wp7Xo9weQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ifdefy the wireless pointers in struct net_device
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        edumazet@google.com, Paolo Abeni <pabeni@redhat.com>,
        johannes@sipsolutions.net, Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        sven@narfation.org, linux-wireless@vger.kernel.org,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, May 16, 2022 at 10:13 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 5/16/2022 2:56 PM, Jakub Kicinski wrote:
> > Most protocol-specific pointers in struct net_device are under
> > a respective ifdef. Wireless is the notable exception. Since
> > there's a sizable number of custom-built kernels for datacenter
> > workloads which don't build wireless it seems reasonable to
> > ifdefy those pointers as well.
> >
> > While at it move IPv4 and IPv6 pointers up, those are special
> > for obvious reasons.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Could not we move to an union of pointers in the future since in many
> cases a network device can only have one of those pointers at any given
> time?

note that ieee802154 has also functionality like __dev_get_by_index()
and checks via "if (netdev->ieee802154_ptr)" if it's a wpan interface
or not, guess the solution would be like it's done in wireless then.

- Alex

