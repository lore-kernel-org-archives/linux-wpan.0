Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD846C43334
	for <linux-wpan@archiver.kernel.org>; Mon,  4 Jul 2022 01:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiGDBOK (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 3 Jul 2022 21:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiGDBNs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 3 Jul 2022 21:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CFF065A2
        for <linux-wpan@vger.kernel.org>; Sun,  3 Jul 2022 18:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656897176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6VkutLRt58AHq8Nn03GgZWZyUXFCmGZ7rv040e8EzE=;
        b=IOjdetpFBpw/Y/ZvjfbyWFieUQTu2g+kA7/rrv/ayampMaBpEEXkpxEmQ2//4WiOsj+rON
        WmyoOPnMECWNIbGmXlVkGsmgGwcjZ0gJ9TxZajcHc4HqGTVlTJLL+HsWYimsV8Z3A3fEhA
        uBSwnPJUSQfJWY9jLOQ9sFb/YYfK/Rw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-x43q8ctiNqCbAaIkFGEZ1g-1; Sun, 03 Jul 2022 21:12:55 -0400
X-MC-Unique: x43q8ctiNqCbAaIkFGEZ1g-1
Received: by mail-qk1-f197.google.com with SMTP id t203-20020a3746d4000000b006af1d3e8068so7410629qka.0
        for <linux-wpan@vger.kernel.org>; Sun, 03 Jul 2022 18:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6VkutLRt58AHq8Nn03GgZWZyUXFCmGZ7rv040e8EzE=;
        b=IC1SERbV/TXRNzooA4tV9BKuGi/wOFF+OGG6okjqW/pURGgLQkuhWVUmPLvl2gxHEv
         ytg4OYcQsvIajX1pqpT1ikxvdlTrAR4kuNJWUCXUk2dVICGXCpcVA6VnhERKc3s/6Hu6
         a9ZReMM0Gyk30iue2JqVdKJ3chz+X9iGw2ebHih+vs739r5BLCr6IBZYB2qHsu719KoS
         H2sl6HWWauh2UpzGC3ACDQv9Tf+UPMnomnRsw6IQ83NK2dqBJAEqo7xFmzBucTB8QRwC
         a+XpJEC6KmcOw5YyuzC1GGFoGe76Ew4KFLW4SojtO+oZCzNg9QowTzegh1PCQ6auGUEH
         1QKA==
X-Gm-Message-State: AJIora981wAc/ysnDnAa0mm3EA8iuGiOG6n9DPVH7iQzaFT0ajceq5kR
        IguHae1RTnGRzedzSttcQowU3AN/z9hPM7krgtiXGfar4f3/h/ufvI20OYkVBvaKaLn2FjTXjrx
        lgN3iRX5cUuhQATq8KbTqwHBW2GHGgwl6hAoE/g==
X-Received: by 2002:a05:622a:38f:b0:305:1ea5:4a7 with SMTP id j15-20020a05622a038f00b003051ea504a7mr7760145qtx.291.1656897174779;
        Sun, 03 Jul 2022 18:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1unUxMt5esZ/+Fv3eQoXGfrd9TWwp72cMFu9/6CDqTg3coES5NffiarICXjmemhUwr7iqw0L6LKLwsGLea/RF0=
X-Received: by 2002:a05:622a:38f:b0:305:1ea5:4a7 with SMTP id
 j15-20020a05622a038f00b003051ea504a7mr7760129qtx.291.1656897174600; Sun, 03
 Jul 2022 18:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com> <20220701143052.1267509-10-miquel.raynal@bootlin.com>
In-Reply-To: <20220701143052.1267509-10-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 3 Jul 2022 21:12:43 -0400
Message-ID: <CAK-6q+hu4YGfU9V5EkRiT+Z8MJhOEeVsVv=vEz5fHPkDL99=TQ@mail.gmail.com>
Subject: Re: [PATCH wpan-next 09/20] net: mac802154: Introduce a global device lock
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Jul 1, 2022 at 10:36 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> The purpose of this device lock is to prevent the removal of the device
> while an asynchronous MLME operation happens. The RTNL works well for
> that but in a later series having the RTNL taken here will be
> problematic and will cause lockdep to warn us about a circular
> dependency. We don't really need the RTNL here, just a serialization
> over this operation.
>
> Replace the RTNL calls with this new lock.

I am unhappy about this solution. Can we not interrupt the ongoing
operation "scan" here and come to an end at a stop?

The RTNL is NOT only to prevent the removal of something... If mostly
all operations are protected by and I know one which makes trouble
here... setting page/channel. I know we don't hold the rtnl lock on
other transmit functionality for phy settings which has other reasons
why we allow it... but here we offer a mac operation which delivers
wrong results if somebody does another setting e.g. set page/channel
while scan is going on and we should prevent this.

Dropping the rtnl lock, yes we can do that... I cannot think about all
the side effects which this change will bring into, one I know is the
channel setting, mostly everything that is interfering with a scan and
then ugly things which we don't want... preparing the code for the
page/channel gives us a direction on how to fix and check the other
cases if we find them. btw: we should do this on another approach
anyway because the rtnl lock is not held during a whole operation and
we don't want that.

We should also take care that we hold some references which we held
during the scan, even if it's protected by stop (just for
correctness).

- Alex

