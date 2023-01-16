Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7798AC46467
	for <linux-wpan@archiver.kernel.org>; Mon, 16 Jan 2023 01:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjAPB5L (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 15 Jan 2023 20:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjAPB4l (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 15 Jan 2023 20:56:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64415CDC8
        for <linux-wpan@vger.kernel.org>; Sun, 15 Jan 2023 17:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673834056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3yuuE5ltojYLr+OPOc1s+CNoWdzLM+TuLPRU0pT3Ikg=;
        b=bVpGF+pNwfoUTgyMAwdlucL/7tJOEJ69E6bAa+tClcI/x1zVySynj6JjJM8Acwbm0qho+N
        RCAAuUO9EDIbLBsBiE6QZnCSAqr9/rNiYmuinH7Tl46rN+kshRVfTrgSy8zt6H2mFzjWxb
        TfrL/JO4Ogx0yP6aiI3ZJHDduw2y8as=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-227-DE8xU1ebNlmuZ_Vdz8_UyA-1; Sun, 15 Jan 2023 20:54:14 -0500
X-MC-Unique: DE8xU1ebNlmuZ_Vdz8_UyA-1
Received: by mail-ed1-f70.google.com with SMTP id m7-20020a056402510700b00488d1fcdaebso17803518edd.9
        for <linux-wpan@vger.kernel.org>; Sun, 15 Jan 2023 17:54:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yuuE5ltojYLr+OPOc1s+CNoWdzLM+TuLPRU0pT3Ikg=;
        b=RtKhwC0aBzsJ0+Q8OKHVu7KPl7P80eEUjSFcStO8e8TUYKLTIl7dGtxEZ7RRf2lgMx
         cxr6O77scYq234i8oJlaoUDwjNr3PxvOX24FWDllK73oJKuhWZGiZYQKe/lIWTFVHDCY
         9SswVXYefjvvYF4XSBNHRktgADY8QpFcTJjrJFAtAiIdBeqINAaW7LAIGxSd4vhmTt4O
         re8npdbF8JZgORiBzQaGHyaaOk8ENp7H4hCo88b5cIjJ1XtxoYAUB9kBm5K9UPKwN/y3
         5ahI7bANKDujoyKOOd0CPLcsThXEYCvtsWwEcCPGSlcCBGdMlE9KGlo1DOV0B+9eI4GV
         UpaA==
X-Gm-Message-State: AFqh2ko2HHM82NScdkbNXg7NkyeEnSewxwWUWYCYdT2dNm5GnX2ZQAKu
        O6QU2tfoe3QSYanGbUkWxEqHsDhaxzufEioK2WB+A+F6kFizKtzEXYcucElG6UwK12JIfBNj5M9
        WtlXS3Lo+1n6hgdXz/dA+xW5Mkolv1VtHsW59Aw==
X-Received: by 2002:a17:906:a2c3:b0:839:74cf:7c4c with SMTP id by3-20020a170906a2c300b0083974cf7c4cmr9182716ejb.265.1673834053768;
        Sun, 15 Jan 2023 17:54:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsrda6ER7HiS8zFF+RznLSBWdkV9MwTjA4ki7ImoWRjl986SSltVk1zUjYFWZIWM4RrDzVrhDb0cRpTRcSINqU=
X-Received: by 2002:a17:906:a2c3:b0:839:74cf:7c4c with SMTP id
 by3-20020a170906a2c300b0083974cf7c4cmr9182708ejb.265.1673834053616; Sun, 15
 Jan 2023 17:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20230106113129.694750-1-miquel.raynal@bootlin.com>
In-Reply-To: <20230106113129.694750-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 15 Jan 2023 20:54:02 -0500
Message-ID: <CAK-6q+jNmvtBKKxSp1WepVXbaQ65CghZv3bS2ptjB9jyzOSGTA@mail.gmail.com>
Subject: Re: [PATCH wpan-next 0/2] ieee802154: Beaconing support
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, Jan 6, 2023 at 6:33 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Scanning being now supported, we can eg. play with hwsim to verify
> everything works as soon as this series including beaconing support gets
> merged.
>

I am not sure if a beacon send should be handled by an mlme helper
handling as this is a different use-case and the user does not trigger
an mac command and is waiting for some reply and a more complex
handling could be involved. There is also no need for hotpath xmit
handling is disabled during this time. It is just an async messaging
in some interval and just "try" to send it and don't care if it fails,
or? For mac802154 therefore I think we should use the dev_queue_xmit()
function to queue it up to send it through the hotpath?

I can ack those patches, it will work as well. But I think we should
switch at some point to dev_queue_xmit(). It should be simple to
switch it. Just want to mention there is a difference which will be
there in mac-cmds like association.

btw: what is about security handling... however I would declare this
feature as experimental anyway.

- Alex

