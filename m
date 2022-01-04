Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FAC433FE
	for <linux-wpan@archiver.kernel.org>; Tue,  4 Jan 2022 18:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbiADS53 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 4 Jan 2022 13:57:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53752 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235913AbiADS52 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Jan 2022 13:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641322648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J5/oRp09czNHRuOEhgWyRyTW+iAZaeWjdUNct+kTpW0=;
        b=PUpTl2EBGegppAYgWpCAkz1vPRNHzwNZ86TSIokMSbP4sMhVjjq4P67ahJmGFtaiCaMOKu
        kzVdHkSJhaP/AjkNcTeS7vL6kzRU2KcU/EiKBtn1ez69k58qo2VQHjIIVWcMhrgw/RHKPi
        zgLLq/jQDNlptCher6KUGdhD81eZyHM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-LuPX_IZuNzmk7teDNCpzkQ-1; Tue, 04 Jan 2022 13:57:25 -0500
X-MC-Unique: LuPX_IZuNzmk7teDNCpzkQ-1
Received: by mail-qv1-f69.google.com with SMTP id kd7-20020a056214400700b0041195fd2977so27177669qvb.5
        for <linux-wpan@vger.kernel.org>; Tue, 04 Jan 2022 10:57:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5/oRp09czNHRuOEhgWyRyTW+iAZaeWjdUNct+kTpW0=;
        b=jap2UU2tn53s6asJUfjdU16//NVj+t8cHh+RO+g/LrVrVfeidiMsD29/961TCIhZu4
         93dkbIva9QtXMe7j+r8aDsWS8L8T4+3n6H+XIR7CJvAPBweimaFtNLniVYtvxls3TfT6
         yv6Z6smL0QqLzmKUBZeMPa9fX6floR6SVyPSWVMLhea+YwOTTrkzvEY/e5ei3ZJuDLn7
         jIYVxWbpn3a2HYXbxh4Qi8gRuGeStB7CTEvDTTPaVqMEsIPoocc/MKQTi3yvZZowPOcF
         8PsX6dfcBCFFei2sm12Qj9dD0rI738jujGMOKlnW++UFxXtA3nIrb3Z22IFB4WTUWZ1t
         235g==
X-Gm-Message-State: AOAM530ThpKMWWqs8T/peb2QlMNkync/fZfX46IrmjdUUJ5GVpo0pMTD
        qBhuW7SIXdAPWGoHxjFqYxrL9N4GmMLkqCl7RlYmyGymYBmEdqoKDGALIPNeEdcaJPMuVO670dr
        eqwGM0YQBT+mzedkEkiV+0L4BCVWpDV3SPU4qUw==
X-Received: by 2002:ac8:4a0e:: with SMTP id x14mr46061152qtq.345.1641322644543;
        Tue, 04 Jan 2022 10:57:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzY5Jb8OM0ChHLxAtBitQbRhduI6iTYF7RWU97ZON70BVaBcUtDPP4ln05Ykg45Jk6Z3AEJnPL9BvW00sROAkI=
X-Received: by 2002:ac8:4a0e:: with SMTP id x14mr46061135qtq.345.1641322644295;
 Tue, 04 Jan 2022 10:57:24 -0800 (PST)
MIME-Version: 1.0
References: <e8e73fcc-b902-4972-6001-84671361146d@datenfreihafen.org> <20220104182806.7188-1-paskripkin@gmail.com>
In-Reply-To: <20220104182806.7188-1-paskripkin@gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Tue, 4 Jan 2022 13:57:13 -0500
Message-ID: <CAK-6q+jkQqZ-Mog2Bwq2EGWFYv-vYtSYRJMqJUARm=C+Cd+uRA@mail.gmail.com>
Subject: Re: [PATCH v3] ieee802154: atusb: fix uninit value in atusb_set_extended_addr
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     stefan@datenfreihafen.org, alex.aring@gmail.com,
        davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
        linux-wpan@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Jan 4, 2022 at 1:28 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Alexander reported a use of uninitialized value in
> atusb_set_extended_addr(), that is caused by reading 0 bytes via
> usb_control_msg().
>
> Fix it by validating if the number of bytes transferred is actually
> correct, since usb_control_msg() may read less bytes, than was requested
> by caller.
>
> Fail log:
>
> BUG: KASAN: uninit-cmp in ieee802154_is_valid_extended_unicast_addr include/linux/ieee802154.h:310 [inline]
> BUG: KASAN: uninit-cmp in atusb_set_extended_addr drivers/net/ieee802154/atusb.c:1000 [inline]
> BUG: KASAN: uninit-cmp in atusb_probe.cold+0x29f/0x14db drivers/net/ieee802154/atusb.c:1056
> Uninit value used in comparison: 311daa649a2003bd stack handle: 000000009a2003bd
>  ieee802154_is_valid_extended_unicast_addr include/linux/ieee802154.h:310 [inline]
>  atusb_set_extended_addr drivers/net/ieee802154/atusb.c:1000 [inline]
>  atusb_probe.cold+0x29f/0x14db drivers/net/ieee802154/atusb.c:1056
>  usb_probe_interface+0x314/0x7f0 drivers/usb/core/driver.c:396
>
> Fixes: 7490b008d123 ("ieee802154: add support for atusb transceiver")
> Reported-by: Alexander Potapenko <glider@google.com>
> Acked-by: Alexander Aring <aahringo@redhat.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>
> Changes in v3:
>         - Changed atusb_control_msg() to usb_control_msg() in
>           atusb_get_and_show_build(), since request there may read various length
>           data
>

Thanks for catching this.

- Alex

