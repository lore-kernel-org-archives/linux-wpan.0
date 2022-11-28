Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21CC4321E
	for <linux-wpan@archiver.kernel.org>; Mon, 28 Nov 2022 22:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiK1WMw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 28 Nov 2022 17:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbiK1WMr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 28 Nov 2022 17:12:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABD82F396
        for <linux-wpan@vger.kernel.org>; Mon, 28 Nov 2022 14:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669673512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XyrmJ1F/utvSUVmfP47rlqRQaLElV4APNWTroTpMjiY=;
        b=C3kGR2Cv93OdyuEWJ3EK+mzYK5aWGGM+9/n9MbKMlcH5mQZKaACesdIT6xayNxaafJMjUH
        5LQxjVxZQvhDML7RcvW61FYMh7A/3AoHOv3s9WU55VS6/Lj/ZwjkgX5Kh3aJZggCkqEVKj
        DT4E6EHwtJct7Hdh7p9A6pRoGN+H0wo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-a2Jzr4ndN1WQuMIda1FS-w-1; Mon, 28 Nov 2022 17:11:50 -0500
X-MC-Unique: a2Jzr4ndN1WQuMIda1FS-w-1
Received: by mail-ej1-f72.google.com with SMTP id qk16-20020a1709077f9000b007c080a6b4ddso896078ejc.18
        for <linux-wpan@vger.kernel.org>; Mon, 28 Nov 2022 14:11:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyrmJ1F/utvSUVmfP47rlqRQaLElV4APNWTroTpMjiY=;
        b=DcwVx2VOpLIOtqXD4koKLQ+R2EAdGaUcOjPUGQuDTp/tk8vq42yjBAC7Pm6/kmH/II
         mMjXPYYYFAvRjNzRFY5Klkh6zFwVCwjRmt4yUlGOvgSNKltr15tV9Z/qPRuop/h5Gv0H
         8AF+KTGlUxf0vr+KUtPir3oOfXoGlFPeWYbj+ub047nnWDmFIhSknEVHXh5LzABN7fsZ
         3n9CPqcwVrYDE1oHxqQ5caPqReFkcpUW8F1FdbGfn5ehNGg2FpggGWmZh/O996LR/vys
         kEtKTcC5IA5PRBOquNaPlxZR1PG28p5uzTTQRe2T2Ot4SzDLLfmzz0fPJLXm6QXFa2G3
         lu9w==
X-Gm-Message-State: ANoB5pmotRtnJua8YNWB/y4urP3f4a6Un3LC0RsnOeA4/agJBK3oNoQn
        9C/2X+9YPu5dGxU0TFBHNN9vKf9s+uAhqAFZ8qyr9bhuJCM7SmkIIrDkOdyhIoXiMDCZbmb5daW
        bmpA4Kp9H6di1S5WIeVgkCIuFqGrvH+/amhtY5Q==
X-Received: by 2002:a17:906:830d:b0:79e:5ea1:4f83 with SMTP id j13-20020a170906830d00b0079e5ea14f83mr31094826ejx.372.1669673509665;
        Mon, 28 Nov 2022 14:11:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4KBuqch1h+pApUwwcB54bGUKQ/xvxNXIXEeZ9GTRgIyEnlDRQZHZqaXKSwPCvnaU3idF5IfOQQxBtuvOjgde4=
X-Received: by 2002:a17:906:830d:b0:79e:5ea1:4f83 with SMTP id
 j13-20020a170906830d00b0079e5ea14f83mr31094814ejx.372.1669673509500; Mon, 28
 Nov 2022 14:11:49 -0800 (PST)
MIME-Version: 1.0
References: <20221118221041.1402445-1-miquel.raynal@bootlin.com>
In-Reply-To: <20221118221041.1402445-1-miquel.raynal@bootlin.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 28 Nov 2022 17:11:38 -0500
Message-ID: <CAK-6q+iLkYuz5csmbLt=tKcfGmdNGP+Sm42+DQRu5180jafEGw@mail.gmail.com>
Subject: Re: [PATCH wpan-next v2 0/2] IEEE 802.15.4 PAN discovery handling
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

On Fri, Nov 18, 2022 at 5:13 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hello,
>
> Last preparation step before the introduction of the scanning feature
> (really): generic helpers to handle PAN discovery upon beacon
> reception. We need to tell user space about the discoveries.
>
> In all the past, current and future submissions, David and Romuald from
> Qorvo are credited in various ways (main author, co-author,
> suggested-by) depending of the amount of rework that was involved on
> each patch, reflecting as much as possible the open-source guidelines we
> follow in the kernel. All this effort is made possible thanks to Qorvo
> Inc which is pushing towards a featureful upstream WPAN support.
>

Acked-by: Alexander Aring <aahringo@redhat.com>

I am sorry, I saw this series today. Somehow I mess up my mails if we
are still writing something on v1 but v2 is already submitted. I will
try to keep up next time.

- Alex

