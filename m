Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D72C43334
	for <linux-wpan@archiver.kernel.org>; Mon, 20 Jun 2022 00:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiFTATA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 19 Jun 2022 20:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiFTAS7 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 19 Jun 2022 20:18:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9084C63DB
        for <linux-wpan@vger.kernel.org>; Sun, 19 Jun 2022 17:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655684336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SLfrfhlqpinSuC1e7NmJIPUACicK3dRhd2HOJDyDTII=;
        b=cSHu2+kjnYkSxtJ1y0ThUeR2yycBDWCZRgaoGOz2+EciOedXMROW16nnTI9xRuGnIkzOn9
        zlBRBjBlPXnIP0iPz3A3ULgQdFx0Ssev2pFbeyeymfcXPjJexp7y0XKTY8TT1/UZRm2xnN
        HyBf9UMeu1DMwyHoqDpqWwQsEPe7Y5w=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-e5zvlp6cNq2pIEtf71NLAA-1; Sun, 19 Jun 2022 20:18:55 -0400
X-MC-Unique: e5zvlp6cNq2pIEtf71NLAA-1
Received: by mail-qk1-f197.google.com with SMTP id k13-20020a05620a414d00b006a6e4dc1dfcso11402608qko.19
        for <linux-wpan@vger.kernel.org>; Sun, 19 Jun 2022 17:18:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SLfrfhlqpinSuC1e7NmJIPUACicK3dRhd2HOJDyDTII=;
        b=KUTlqfCFHwmwY2utyRe630NcCtTsTTz8yYKnlLxXUA/Dkx0T0gPX04df8OQwSpTJDj
         TOiep+9Lri0+hYFDihiAH5el8WXZf1UbYDkeh/cFhGOG/nt9Cbf/wH1+DEBxKTevaEd4
         Gvt2K4lssekOZhEyv/9yNiNFmPIGgHH+eaqMUg9hk+GYP890cBjV3tPUE6B/zyD7ecyw
         Ccv/dYSKxczsYZ8fKFTCpBggvyu+xhLcX4zY/6n4D8gu18I/+GP3Ixu0E6Roz2wfjvn8
         aJBg5p0pJBhMNLwYFMOV+si2CnY65hT95A+ZKguxyn7poJDbyRtq228PgCYIN0lSAnHW
         cPtA==
X-Gm-Message-State: AJIora94UZ2IvYGqliEiy81sENVjwTfyS1K0aeZxRDgQ7sjnMRxSjVLK
        s0uGfzF3HxvCJWvryXFPGNx0Nq15Q4ikw8JGzZDPbPhWZhHfkZWw/eB5f0IEOkpxpgMroyDHqDi
        5jzpIoAmET06ey/4eC7RHzqkpER//K13SEU+lvQ==
X-Received: by 2002:ad4:5f86:0:b0:46b:9505:5a27 with SMTP id jp6-20020ad45f86000000b0046b95055a27mr17320494qvb.2.1655684334286;
        Sun, 19 Jun 2022 17:18:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thTe2XjVhYPTCEnglkDVKklUExrjSdP1lgka0lgsmW5CH/h38CBpXiFRQRBTp2xva9dO6cLin/+Lh5Qt+HSa4=
X-Received: by 2002:ad4:5f86:0:b0:46b:9505:5a27 with SMTP id
 jp6-20020ad45f86000000b0046b95055a27mr17320479qvb.2.1655684334107; Sun, 19
 Jun 2022 17:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220617193254.1275912-1-miquel.raynal@bootlin.com> <20220617193254.1275912-2-miquel.raynal@bootlin.com>
In-Reply-To: <20220617193254.1275912-2-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 19 Jun 2022 20:18:43 -0400
Message-ID: <CAK-6q+g7pd14Bhng9r210kROttwtqQkF1JgAF283B9MPc22g3g@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 1/6] net: ieee802154: Create a device type
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

On Fri, Jun 17, 2022 at 3:35 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> A device can be either a fully functioning device or a kind of reduced
> functioning device. Let's create a device type member. Drivers will be
> in charge of setting this value if they handle non-FFD devices.
>
> FFD are considered the default.
>
> Provide this information in the interface get netlink command.
>
> Create a helper just to check if a rdev is a FFD or not, which will
> then be useful when bringing scan support.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/net/nl802154.h    | 9 +++++++++
>  net/ieee802154/core.h     | 8 ++++++++
>  net/ieee802154/nl802154.c | 6 +++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/nl802154.h b/include/net/nl802154.h
> index 145acb8f2509..5258785879e8 100644
> --- a/include/net/nl802154.h
> +++ b/include/net/nl802154.h
> @@ -133,6 +133,8 @@ enum nl802154_attrs {
>         NL802154_ATTR_PID,
>         NL802154_ATTR_NETNS_FD,
>
> +       NL802154_ATTR_DEV_TYPE,
> +
>         /* add attributes here, update the policy in nl802154.c */
>
>  #ifdef CONFIG_IEEE802154_NL802154_EXPERIMENTAL
> @@ -163,6 +165,13 @@ enum nl802154_iftype {
>         NL802154_IFTYPE_MAX = NUM_NL802154_IFTYPES - 1
>  };
>
> +enum nl802154_dev_type {
> +       NL802154_DEV_TYPE_FFD = 0,
> +       NL802154_DEV_TYPE_RFD,
> +       NL802154_DEV_TYPE_RFD_RX,
> +       NL802154_DEV_TYPE_RFD_TX,
> +};

As I said in another mail, I think this is a "transceiver capability"
why it is required that a user sets a transceiver capability. It means
that you can actually buy hardware which is either one of those
capabilities, one reason why D in those acronyms stands for "Device".
In SoftMac you probably find only FFD but out there you would probably
find hardware which cannot run as e.g. coordinator and is a RFD.

- Alex

