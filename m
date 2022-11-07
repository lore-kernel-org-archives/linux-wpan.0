Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AF8C4332F
	for <linux-wpan@archiver.kernel.org>; Mon,  7 Nov 2022 01:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbiKGBha (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 6 Nov 2022 20:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiKGBh3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 6 Nov 2022 20:37:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F7B1EA
        for <linux-wpan@vger.kernel.org>; Sun,  6 Nov 2022 17:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667784995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3uI754LLZNATMly5kau/BPm2HAT37g06wdUxjM84Yo=;
        b=ZIy1nF+TEc8wPfIQp2QGSM6TLNEj1Z6VxEt3PsbpHV0NaDvlUxfWm0ROZRIcLlnZFimydJ
        yNSS7NNJegxpiNbKFyahlPdxKF9mweXY5lK5XeCIWk9kCZZeDT0G/N/D/rBXv1U8PqMssT
        zA75B6NbSjnXh1/ZEGlmDkKahsraZ00=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-ZrYfpqWpOoSqSBVYOnISAQ-1; Sun, 06 Nov 2022 20:36:33 -0500
X-MC-Unique: ZrYfpqWpOoSqSBVYOnISAQ-1
Received: by mail-ed1-f71.google.com with SMTP id w17-20020a056402269100b00461e28a75ccso7205009edd.8
        for <linux-wpan@vger.kernel.org>; Sun, 06 Nov 2022 17:36:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3uI754LLZNATMly5kau/BPm2HAT37g06wdUxjM84Yo=;
        b=wV2VIWozd05hn5MzkbzBlkHhmHgZ3RKHGn0WvIXnLH1lG+Nv5Ji7+DqIS5avCvjYKM
         wJu6nmST6wv9/X6tDE7lfzUHKka/srKq10K0JZ7BW0yW5BBQ+llKccc3dP/Ve7jkhl/+
         WvuI4/LzpM93rtvegg7+8FG7KrPu5YCUambKYh6O9W4bB8TVl/npudqN5QrUoMh9qYeh
         EY5bJZNy7pWF7UABT3pbzLrtA0bJwuTqFtjRi4lyk06i1rSWmiwH39IEP72NjkJLxpsg
         kMtkwGqWZTbgQeFjMR2TQbX19EDHz0gNdJy6BhbnjfmG6xqlyCPjcFStm/QcNQ8q+xHk
         JcsA==
X-Gm-Message-State: ACrzQf2tGqLfymnwmz819g1RWauNDssCdFJa9zakULQPN7F5uq5JVBho
        wW2PmQjUNUje4IlHTzuVelu9vkvtReypLzAqZqq0rKCC++vc/eR83e3eQ9CjsKArOkqcyEz/Pln
        ILtNRY4AhmTqygEMpn/gylA1m4hsKCw3jc0vTvg==
X-Received: by 2002:a17:907:8b94:b0:7ae:5884:b344 with SMTP id tb20-20020a1709078b9400b007ae5884b344mr7198833ejc.373.1667784992611;
        Sun, 06 Nov 2022 17:36:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5xIcdB+Li+bISH9qIgQvy44nYhhFhuxp4d1wBKUOAQbwDNACPnMm7hgmLMNl6TcyETEF794G2M6FQwu2iWeeY=
X-Received: by 2002:a17:907:8b94:b0:7ae:5884:b344 with SMTP id
 tb20-20020a1709078b9400b007ae5884b344mr7198805ejc.373.1667784992429; Sun, 06
 Nov 2022 17:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20221102151915.1007815-1-miquel.raynal@bootlin.com> <20221102151915.1007815-4-miquel.raynal@bootlin.com>
In-Reply-To: <20221102151915.1007815-4-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 6 Nov 2022 20:36:21 -0500
Message-ID: <CAK-6q+jDFGr2xhAKLLitZXA2Q2dWgeZjgBXHubHvOvzX-xeB-w@mail.gmail.com>
Subject: Re: [PATCH wpan-next 3/3] ieee802154: Trace the registration of new PANs
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, Nov 2, 2022 at 11:20 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> From: David Girault <david.girault@qorvo.com>
>
> Add an internal trace when new PANs get discovered.

I guess this will not be the API for the user that there is a PAN
discovered? Is it only for debugging purposes? There will be an
nl802154 event for this? As we discussed previously with additional
commands for start, discovered, etc.?

I am sorry, maybe I can read that somewhere on your previous patch
series, just want to be sure.

- Alex

