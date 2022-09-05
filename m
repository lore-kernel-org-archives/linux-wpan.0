Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61444ECAAA1
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Sep 2022 23:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiIEXeE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 5 Sep 2022 19:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEXeD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 5 Sep 2022 19:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84A66A60
        for <linux-wpan@vger.kernel.org>; Mon,  5 Sep 2022 16:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662420840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBVHw9yWt6hhZW8L/kpHrk7pzGZqEyVADvRpEVs6JCo=;
        b=O4oHaJWDf7+uIEnSSJB6nDh7hZShCIcQRpQNTGAz/KXDZwLWQlR91AUFfVFi4zVfMdwM1S
        An7T9RpB9q1sc0AfQshrUhAczRulZvhQcHr5/NF/GiyAuIJO849ifmpcsR07xwKpJAAWRL
        gFaWzRg5LBjZOwQ3EhmUgFtg5Aw/IS8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-dQPB6g3tObOPIFJkUmA-LA-1; Mon, 05 Sep 2022 19:33:59 -0400
X-MC-Unique: dQPB6g3tObOPIFJkUmA-LA-1
Received: by mail-qt1-f198.google.com with SMTP id o22-20020ac85a56000000b0034481129ce6so7727439qta.19
        for <linux-wpan@vger.kernel.org>; Mon, 05 Sep 2022 16:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iBVHw9yWt6hhZW8L/kpHrk7pzGZqEyVADvRpEVs6JCo=;
        b=74gb7DnzKr7+Ig7uP2PAqY8q2HWLYffEXJ/JzXx9uiFF00GycPjVUUfjQZ/Y5z+bUD
         uH3S9MkWpNiPSt1Qr/04f0JE2GKDbjuQRcQCEjwiSU0cJlqLCWrtupkdwMpuNL/RPvxl
         M6XxsFDmHHKBbWekc+jKQO/cWzspceuiF0NMHex9fhzeYkwxgEaIb0W6awD5J++AIr5O
         UbfiqYF199VHlXIR6qzR780qgYuP/DSpoTW3vECnwog12uCegUKknborxOPw5P0Mv/U8
         ai7ZqGzrraLBxDTS1jFI8rBoiiH4qRZT5QrCR30kLzOdu7U9eXknU3V2Qy4fgiABnvOE
         wP8g==
X-Gm-Message-State: ACgBeo0X2xCUlJS5cRfr34vfY5gZ+k+SzyQ/hMevlJBMgquYkDhI9oqL
        T5tdyaqyEp7dii7rc4sgI2iq37u6lebHbaVljR689ikcG37wfUj1xSe/8YkfBYtXVlDw17noO89
        ZqaCrl/t7qGWlZGi4gB/4XfgyMRKaK9oY0vTwDw==
X-Received: by 2002:a05:620a:44cb:b0:6c9:c460:8838 with SMTP id y11-20020a05620a44cb00b006c9c4608838mr137431qkp.770.1662420839118;
        Mon, 05 Sep 2022 16:33:59 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4t9AvECblHZ47zur2/xYVRLAJ1gGhWD19wFkS28hZFdEZxsqHSGM7q41HVl4x8VX8Yea/aLUnpYr7f+Mm/mjM=
X-Received: by 2002:a05:620a:44cb:b0:6c9:c460:8838 with SMTP id
 y11-20020a05620a44cb00b006c9c4608838mr137416qkp.770.1662420838753; Mon, 05
 Sep 2022 16:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
In-Reply-To: <20220905204318.1324284-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 5 Sep 2022 19:33:47 -0400
Message-ID: <CAK-6q+hM5_uVurQL3ctrWcpF6EozcNSkC0uZF3n5AxispSM8uQ@mail.gmail.com>
Subject: Re: [PATCH atusb/fw 1/2] atusb: fw: Update toolchain instructions
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     werner@almesberger.net, Stefan Schmidt <stefan@datenfreihafen.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Sep 5, 2022 at 4:43 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Those instructions do not work anymore for several reaons:
> - Two out of the three files to download return a 404 error:
>       * The binutils version does not exist, it was 2.21.1 or 2.21.1a
>         instead of just 2.21.
>       * The avr-libc is no longer hosted on the pointed website, I've
>         found an alternate.
> - The binutils version mentioned is not able to compile the firmware on
>   a recent distribution, the Internet advised to update its version and
>   it worked.
> - Most of these compilations will throw warnings if you use a recent
>   gcc. Sometimes -Werror is set and it fails the build. To avoid that,
>   just use --disable-werror in the ./configure options.
> - I had issues building the gcc doc but those issues are trivial to
>   fix inline.
>
> Update the instructions for building the toolchain and while at it,
> start the file by mentioning that this is maybe not useful anymore, and
> provide the packets to install.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  atusb/fw/README | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/atusb/fw/README b/atusb/fw/README
> index 99ceb22..44f65f5 100644
> --- a/atusb/fw/README
> +++ b/atusb/fw/README
> @@ -1,4 +1,6 @@
> -Requires a very recent toolchain, because ATmega32U2 is relatively new.
> +- Toolchain:
> +
> +  apt install avr-gcc libc-avr
>

grml, it's just the other name around... but I think an important
notice is here "use the debian packages".

gcc-avr avr-libc

I know it was swapped and was not checking it... it was a 50/50 chance.

- Alex

