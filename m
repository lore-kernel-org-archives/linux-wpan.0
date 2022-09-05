Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01367ECAAD5
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 01:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiIEBLL (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Sep 2022 21:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiIEBLJ (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Sep 2022 21:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB01C2716E
        for <linux-wpan@vger.kernel.org>; Sun,  4 Sep 2022 18:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662340267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrO09u2qKQjYI/XRl8sc5wIYxptIQ3bjIu488Hie+Tc=;
        b=H96FKEqfPYl3KNuNwHP4DCdu96ifxF9P+YmdssWjTpPlQaYtQRSMoERdySpeaJlwX6v1ux
        d9G9hG4/5GdHpFAM9IwI77OrY/55foexkunjLNwCINdL/bB9M5eUGsdNFz3kC7owiefyVf
        Rz0P7Uk95EiK3gRTv9uXfGunJ/w9ZiA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-CxpAarTYPdiVvB3plSrtOQ-1; Sun, 04 Sep 2022 21:11:06 -0400
X-MC-Unique: CxpAarTYPdiVvB3plSrtOQ-1
Received: by mail-qt1-f198.google.com with SMTP id v5-20020ac873c5000000b003434ef0a8c7so5956591qtp.21
        for <linux-wpan@vger.kernel.org>; Sun, 04 Sep 2022 18:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JrO09u2qKQjYI/XRl8sc5wIYxptIQ3bjIu488Hie+Tc=;
        b=jjPYi4IaTvIIDIDiDHVREXJqD4QtRxxk2rRaGuQiVLg3ELshKxKLh66UkuqkM/SLLx
         TOuHbv6p38eSBbdkiNfqydSup5mzsasohmjAPlbgSIIVAuMoXlg29iDBCmrxmTX2THst
         grAFV13q54ThayYJmKKnGHYnUfm+jx+vuz6mfufo7aGc+ttJEEce7jTmLY31KjGZO1wF
         fY+1UGTR2QuWbXxQrJvXa8HoUhetdU/LAzbsLDalcyAKaF0dHl8loC+KfiHRkuWho7pq
         suL1YPFsf1zxEjZEX6Ghj5huI0n95bOxKGC5RpPiAZOSVyZYEkpvBO+CjuZsk7ukn/Uc
         l5KQ==
X-Gm-Message-State: ACgBeo2Y+I0wWGJDgA4ceKzN/tdaBIDn3/1iNmtkRomRy6Yrh3sr9lGN
        zkbCef5vsjhsCAU+vAn24DslgeFVcojJbdPU5xPzQDKoROaWx2RlqvZLveJT8FaEr8Lpuv3kjiI
        CVP23Nyspsx4qXXSjq+5oMfqvRP6vHbX3LKC6Ew==
X-Received: by 2002:a05:6214:1bce:b0:499:504:7631 with SMTP id m14-20020a0562141bce00b0049905047631mr30091839qvc.92.1662340266328;
        Sun, 04 Sep 2022 18:11:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DvVACzKqY33qQ1RV4gcJ0D18hDs9DqWCHwaehelcvNwctA2MC3uPpy/GK3RSEMUF5xdU51wOoJYtjhjgkK/8=
X-Received: by 2002:a05:6214:1bce:b0:499:504:7631 with SMTP id
 m14-20020a0562141bce00b0049905047631mr30091834qvc.92.1662340266165; Sun, 04
 Sep 2022 18:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220905010810.1010911-1-aahringo@redhat.com> <20220905010810.1010911-2-aahringo@redhat.com>
In-Reply-To: <20220905010810.1010911-2-aahringo@redhat.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 4 Sep 2022 21:10:55 -0400
Message-ID: <CAK-6q+j8aQAPrj2HVUD2SmYijpt=bH=rheqqU0toZGNaPyj2YA@mail.gmail.com>
Subject: Re: [RFC wpan-next 2/2] net: mac802154: set filter at drv_start()
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, Sep 4, 2022 at 9:09 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> The current filtering level is set on the first interface up on a wpan
> phy. If we support scan functionality we need to change the filtering
> level on the fly on an operational phy and switching back again.
>
> This patch will move the receive mode parameter e.g. address filter and
> promiscuous mode to the drv_start() functionality to allow changing the
> receive mode on an operational phy not on first ifup only. In future this
> should be handled on driver layer because each hardware has it's own way
> to enter a specific filtering level. However this should offer to switch
> to mode IEEE802154_FILTERING_NONE and back to
> IEEE802154_FILTERING_4_FRAME_FIELDS.
>
> Only IEEE802154_FILTERING_4_FRAME_FIELDS and IEEE802154_FILTERING_NONE
> are somewhat supported by current hardware. All other filtering levels
> can be supported in future but will end in IEEE802154_FILTERING_NONE as
> the receive part can kind of "emulate" those receive paths by doing
> additional filtering routines.
>
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>
> RFC as code snippet as requested to somehow deal with the current
> driver-ops and switching between filters with address filtering (AACK on)
> and non-address filtering (AACK off) which is necessary for scanning in
> this case it will be NONE because that's what we currently support and I
> hope it can useful for scanning receive mode.
>

based on wpan-next/master with:

[PATCH wpan-next v2 01/11] net: mac802154: Introduce filtering levels

applied.

- Alex

