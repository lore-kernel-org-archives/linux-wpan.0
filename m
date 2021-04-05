Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7A2C433B4
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 03:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A01B6108B
	for <linux-wpan@archiver.kernel.org>; Mon,  5 Apr 2021 03:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhDEDuS (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 4 Apr 2021 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhDEDuR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 4 Apr 2021 23:50:17 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CFBC061756
        for <linux-wpan@vger.kernel.org>; Sun,  4 Apr 2021 20:50:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ay2so5060162plb.3
        for <linux-wpan@vger.kernel.org>; Sun, 04 Apr 2021 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x0xsbLgyZYmwGan+CyoN8Zxhi2tKOWoIzOz72WFhQd8=;
        b=Fo62ehfi6KMjVYxMIClSdeg+VJFgRKjM3RXGLlNaVN6KJmcKpOA4BabKXzTuhBmgL0
         BtV2nhrTuLbyMv0+VAY9m3rRI5zQuwjTOmommYWTFKzKMUpZRhwBrs88opciGCwb8/sq
         B1I7ECaOIO7GaDWnrzK6Pri+zHV+dOyrQtqB5G9Wn7P/SJhcfRyqxumDZfFEXZil2ojB
         GCSF1Ng1QBrvT6S2I2pk3n7SCmuqpar6LjcpyJ0AQb54olmLJsWuDQg11P9vM0K1SdqC
         dtffP//Q8+ZU9VF0g1sa2MU5vyt0bZEnW6dZg0PNJ8ymxi1HvTcpSEvRgIs5qe4aKG4A
         xpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x0xsbLgyZYmwGan+CyoN8Zxhi2tKOWoIzOz72WFhQd8=;
        b=rHuyfF2R0IIQkijHMJzv99+efVcrAjbtlfcHDyMHBQgRalL1YKG/5unUiqo0Ka6anN
         +RhZ9x2mOX3NAI7GoogdRQvQvvEg8nP336DaIEPSuSpb102BjD3no5Tca41KZmaOW0i4
         +PLmje6vzzesviDEIztRd1OkUOUr+F8ReNIi1SjeuoElifz4e2SWNb2GeZHoD9gmm1Jh
         2JxhwLo14NVEtZgYH3G1qyLncsvC4gK5DgW9ALIx3HcEBQB9f90HYDu9BCkUb0ZW5rPd
         6am/bWNEzQ/xRmxdfHJvPVlMiEnjzHbHoDe/IHf+4p4DbjgKZ9QX7DlmXl6kefIiOFZH
         MBnA==
X-Gm-Message-State: AOAM532H/m8iWSd7VjpFWoZnbDgF4c5AtPPcZtdj2MBel/03fSTx7xJb
        2XxQS2X1CfHCuix1dJXj3LB0S9NibX5Q7up6
X-Google-Smtp-Source: ABdhPJzXIx42rAffdViYmMrRaw8436UB6bOu+vlAavRm4KntBRnTUrZqfhGPEGPUWvjM7oGZFp2uAA==
X-Received: by 2002:a17:902:d2c7:b029:e6:34e2:7a83 with SMTP id n7-20020a170902d2c7b02900e634e27a83mr22288553plc.60.1617594611350;
        Sun, 04 Apr 2021 20:50:11 -0700 (PDT)
Received: from nuc ([202.133.196.154])
        by smtp.gmail.com with ESMTPSA id gb1sm13960113pjb.21.2021.04.04.20.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 20:50:10 -0700 (PDT)
Date:   Mon, 5 Apr 2021 11:50:07 +0800
From:   Du Cheng <ducheng2@gmail.com>
To:     Alexander Aring <alex.aring@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        skhan@linuxfoundation.org,
        syzbot+cde43a581a8e5f317bc2@syzkaller.appspotmail.com
Subject: Re: [PATCH] net:mac802154: add init of .sec and .sec_mtx for sdata
 in ieee802154_setup_sdata
Message-ID: <YGqI7w1Aj9+ilut9@nuc>
References: <20210404045712.50954-1-ducheng2@gmail.com>
 <CAB_54W5BwCoJ9u45PZrZpF49Jzh41eGvysG0KwrhoFD8e5y1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB_54W5BwCoJ9u45PZrZpF49Jzh41eGvysG0KwrhoFD8e5y1Ng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Le Sun, Apr 04, 2021 at 08:33:48PM -0400, Alexander Aring a écrit :
> Hi,
> 
> On Sun, 4 Apr 2021 at 00:57, Du Cheng <ducheng2@gmail.com> wrote:
> >
> > add mutex_init(&sdata->sec_mtx) and mac802154_llsec_init(&sdata->sec) for
> > NL802154_IFTYPE_MONITOR inside ieee802154_setup_sdata. As the unintiated
> > mutex and sec data structure were used in ieee802154_get_llsec_params
> > which would cause a kernel crash. BUG reported by syzkaller.
> 
> this patch will fix it in a way that the user is allowed to set llsec
> parameters for monitors but they will never use them because it's not
> supported. I resend my patch series which should forbid monitors to
> set any llsec parameters for now and the user will be aware that this
> feature isn't supported right now.
> 
> Thanks.
> 
> - Alex

Hi Alex,

Noted. Please CC me when you send your patch series.
Thanks!

Regards,
Du Cheng
