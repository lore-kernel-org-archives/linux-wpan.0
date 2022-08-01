Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBDDC00144
	for <linux-wpan@archiver.kernel.org>; Mon,  1 Aug 2022 23:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiHAXyh (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiHAXyh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Aug 2022 19:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13A2343E60
        for <linux-wpan@vger.kernel.org>; Mon,  1 Aug 2022 16:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659398075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tSd2NToDUTYIW2AcecmoPejo8WOBiujwBj5FJkpTbYU=;
        b=iGvvPM5jf2YnyiA8WD5z34OJnaTeU1dOymXmCxNAllqMG/PCZ9jbfWeBNVnAJ3TYC+yfde
        vWxsfHlNcYgfzqN82jBBdSDdbbGvqFAXRDmsmPf7pIiBODxK/aqHknunFT8oqjuG8GIpId
        OnNaKjyNNTy3Nqeb7iaJhAaJjFR32m0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-DTWJodPOOPOIBBtKJH3nZg-1; Mon, 01 Aug 2022 19:54:34 -0400
X-MC-Unique: DTWJodPOOPOIBBtKJH3nZg-1
Received: by mail-qt1-f198.google.com with SMTP id f1-20020ac84641000000b0031ecb35e4d1so7945079qto.2
        for <linux-wpan@vger.kernel.org>; Mon, 01 Aug 2022 16:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tSd2NToDUTYIW2AcecmoPejo8WOBiujwBj5FJkpTbYU=;
        b=QeWfgDthqhfGxManspfNXO40bV99wBYa2c6qXh3yOyPvmvUMcw1Q7wPjCpVLlou8MC
         ZAUKc4nUWepkLM6IjeCY9mlLxg+vbZFOb4fSYFasDkmXGCPKia1WHqarpDBd9gWe7rp6
         GsWvAgz30RoakLibWmabA6OdWcXoYykGqDp0OLepuScrfC+e4mQ6WLBGVTdg1BoXKJSD
         m9qCj1r3v1eujaWGxL3ga9tGB1s2X/tSuv1oVv42MNgOtxjcqUG5u5/3PtqJ2kg1lz+P
         OIT/fV0909sp215FzmEzvViOnyFKQGcd7U4gImq2/9bwfErtMjcdVbhCr7T5OY3q3jOQ
         UBYg==
X-Gm-Message-State: AJIora9QUhl6RbunB70vWEju09uvzsbdzmPwmCnkwDSCK1qkHWE3xOPk
        Qux1AkUe9vFaGKkd+Kq82gUSazdk9c2aDl/rWKi7a2uSHySVwwlyShHqZXBFDZIqRbmfeVXKFLU
        8sktT1nw4HWGmnlne7uHohsiXzebHH51qB2Wr5Q==
X-Received: by 2002:a05:620a:469f:b0:6b6:74c:6b10 with SMTP id bq31-20020a05620a469f00b006b6074c6b10mr13301085qkb.80.1659398073451;
        Mon, 01 Aug 2022 16:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t1dUKdB2V8yJxCMGiTgXeqFVeuGKKwF839fo9VSL8FWjh9Ho2U0KH9YQgAXoOlvRC8KmDdBJMOh48eagRFjfM=
X-Received: by 2002:a05:620a:469f:b0:6b6:74c:6b10 with SMTP id
 bq31-20020a05620a469f00b006b6074c6b10mr13301075qkb.80.1659398073267; Mon, 01
 Aug 2022 16:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220701143052.1267509-11-miquel.raynal@bootlin.com> <CAK-6q+giwXeOue4x_mZK+qyG9FNLYpK6T5_L1HjaR6zz2LrW-A@mail.gmail.com>
 <CAK-6q+j7MGuHmQtMm8bHzV5WhsSgx=wntWuQUf+MWpa1VZ7NYg@mail.gmail.com>
In-Reply-To: <CAK-6q+j7MGuHmQtMm8bHzV5WhsSgx=wntWuQUf+MWpa1VZ7NYg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 1 Aug 2022 19:54:22 -0400
Message-ID: <CAK-6q+ihyGycUAOcF-UWs49YAtJi3so-aaRAodsD6ikxuhpX=Q@mail.gmail.com>
Subject: Re: [PATCH wpan-next 10/20] net: mac802154: Handle passive scanning
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

On Mon, Aug 1, 2022 at 7:42 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Thu, Jul 14, 2022 at 11:33 PM Alexander Aring <aahringo@redhat.com> wrote:
> ...
> >
> > I know some driver datasheets and as I said before, it's not allowed
> > to set promiscuous mode while in receive mode. We need to stop tx,
> > what we are doing. Then call stop() driver callback,
> > synchronize_net(), mac802154_set_promiscuous_mode(...), start(). The
> > same always for the opposite.
> >
>
> I think we should try to work on that as a next patch series to offer
> such functionality in which "filtering level" the hardware should be
> "started". As I said it cannot be changed during runtime as
> "transceiver is being in receive mode" but there is the possibility to
> stop/start the hardware _transparent_ from the user to change the
> "filtering level". I say filtering level because I think this is what
> the standard uses as a term. The one which is needed here is
> promiscuous mode, otherwise yea we usually use the highest filtering
> level. When changing the "filtering level" it depends on interface
> type what we need to filter in softmac then and what's not. One thing
> in promiscuous mode and everything else than monitor is to check on if
> the checksum is valid and drop if necessary, same for address
> filtering, etc. I don't assume that the software filtering is 100%

forget the address filtering, this is only required when it operates
in non scan mode. It always depends, however you don't need to
implement it if it's not necessary. I think we should somehow get a
per parameter at receive path to know on which filtering level it was
received, then more handling in regarding which receive path it goes
can be made, e.g. if frame xy was received in promiscuous mode. For
scan you don't need to check address filter but checksum, other
receive path have different requirements (not saying that those exists
right now but may in future).

- Alex

