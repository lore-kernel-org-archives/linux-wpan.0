Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BF5C38145
	for <linux-wpan@archiver.kernel.org>; Thu,  8 Sep 2022 01:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIHBk3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 7 Sep 2022 21:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIHBk2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Sep 2022 21:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F79C6FC4
        for <linux-wpan@vger.kernel.org>; Wed,  7 Sep 2022 18:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662601226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omTeNvcKp/F4WU/b2YX04Q0z1z9EGBUTXmAYav/J+8I=;
        b=dOlM5IQmVAjNmmq5UzdWy4f9v+SJjLna1L6AprYd1zTZmzT+T/d3rfJsN6I46F0owtdjug
        ZS8GrELwzqQ794F2eELd7mVhoChstEJvOyJnUs7i555zZwOLL42TY2FDGMZBhxIap3TzBb
        F/CAl1h9BkxGxILCHMZCMZiAn39TGhk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-122-nmuYUTu7MGubD1tHs5KGiA-1; Wed, 07 Sep 2022 21:40:25 -0400
X-MC-Unique: nmuYUTu7MGubD1tHs5KGiA-1
Received: by mail-yb1-f197.google.com with SMTP id 62-20020a250341000000b006a93b57e2daso6976110ybd.2
        for <linux-wpan@vger.kernel.org>; Wed, 07 Sep 2022 18:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=omTeNvcKp/F4WU/b2YX04Q0z1z9EGBUTXmAYav/J+8I=;
        b=UHLuP628M3qLvHc/RqncowN0ZIsJKT5suSMpw8kIz1TLvC0OTbEDdJrO7sgWd7doI7
         +ou0XqHGqIecJp+BJ1sH2h0/K6uB955kC22Rt/j9Ex4cKVfKGoey/3mvOn47r8myYkFJ
         3H9NLiYRDRJfpcr9fIdhTJl3Npt8f3jBwH3dC08DB5H6aLZbJtBwRdsuq8Av/5DARhBW
         InjdujCkzJhMcrpe1h6RA4t7lMjtIINf6P23jNp/OsQ8bsT0tGN7dCPMZ738SnNHp8sz
         ttJYXzfHecgIj1v5RQYuI/j7rR86ZRHHpixWGqB3qcxnrFRVKBFrIN58Nc+NWL394HQP
         8hmQ==
X-Gm-Message-State: ACgBeo3dzolOTf0+myaJzNl5+rnKf3oyBP9N6ynnrXCeKX8bi7MZJ/RO
        9KCIK93tQpim0xzcm0KSQup7g51tfg9IrWSb1kIEfbLy5JZDlQwfGhLzSy4mAAm/GxyCmzBUQ1S
        auVe8h2Hz8Sqk0yDBdYMcnPx/T9F7jPEWLG9D0w==
X-Received: by 2002:a81:1353:0:b0:345:34b5:ad29 with SMTP id 80-20020a811353000000b0034534b5ad29mr5649142ywt.17.1662601224876;
        Wed, 07 Sep 2022 18:40:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5LZWdEKyps6F3LhUYn+aKdzCf042LfowbjEVJPv2xs6teQumCPjTo+wP371qgCXE/dW4wx5ZMJEoBMQXO4/y0=
X-Received: by 2002:a81:1353:0:b0:345:34b5:ad29 with SMTP id
 80-20020a811353000000b0034534b5ad29mr5649140ywt.17.1662601224700; Wed, 07 Sep
 2022 18:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220905203412.1322947-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220905203412.1322947-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 7 Sep 2022 21:40:13 -0400
Message-ID: <CAK-6q+g64BTFsHKKwoCqRGEERRgwoMSTX2LJMQMmmRseWBi=hQ@mail.gmail.com>
Subject: Re: [PATCH wpan/next v3 0/9] net: ieee802154: Support scanning/beaconing
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

On Mon, Sep 5, 2022 at 4:34 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> A third version of this series, dropping the scan patches for now
> because before we need to settle on the filtering topic and the
> coordinator interface topic. Here is just the filtering part, I've
> integrated Alexander's patches, as well as the atusb fix. Once this is
> merge there are a few coordinator-related patches, and finally the
> scan.

I think we have a communication problem here and we should talk about
what the problems are and agree on a way to solve them.

The problems are:

1. We never supported switching from an operating phy (interfaces are
up) into another filtering mode.

2. Scan requires to be in "promiscuous mode" (according to the
802.15.4 spec promiscuous mode). We don't support promiscuous mode
(according to the 802.15.4 spec promiscuous mode). We "can" however
use the currently supported mode which does not filter anything
(IEEE802154_FILTERING_NONE) when we do additional filtering in
mac802154. _But_ this is only required when the phy is scanning, it
will also deliver anything to the upper layers.

This patch-series tries to do the second thing, okay that's fine. But
I thought this should only be done while the phy is in "scanning
mode"? The other receive path while not in promiscuous mode
(phy->filtering == IEEE802154_FILTERING_4_FRAME_FIELDS) should never
require any additional filtering. I somehow miss this point here.

For 1), the driver should change the filtering mode" when we start to
"listen", this is done by the start() driver callback. They should get
all receive parameters and set up receiving to whatever mac802154,
currently there is a bit of chaos there. To move it into drv_start()
is just a workaround to begin this step that we move it at some point
to the driver. I mention 1) here because that should be part of the
picture how everything works together when the phy is switched to a
different filter level while it's operating (I mean there are running
interfaces on it which requires IEEE802154_FILTERING_4_FRAME_FIELDS)
which then activates the different receive path for the use case of
scanning (something like (phy->state & WPANPHY_SCANING) == true)?

I am sorry, but I somehow miss the picture of how those things work
together. It is not clear for me and I miss those parts to get a whole
picture of this. For me it's not clear that those patches are going in
this direction.

- Alex

