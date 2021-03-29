Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A539C433C1
	for <linux-wpan@archiver.kernel.org>; Mon, 29 Mar 2021 15:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD35E61964
	for <linux-wpan@archiver.kernel.org>; Mon, 29 Mar 2021 15:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhC2P4G (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhC2Pzd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 29 Mar 2021 11:55:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7360AC061756
        for <linux-wpan@vger.kernel.org>; Mon, 29 Mar 2021 08:55:30 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n140so13489935oig.9
        for <linux-wpan@vger.kernel.org>; Mon, 29 Mar 2021 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=A+Lf0Hs68q20LSR1Qh3T82K4UKYgxMMT0FqaabUxcKU=;
        b=ImFpFQMzcJetDQFgaT/R9Bn8WAWX505Q6YWy1mG3XLemOP18jRQiaGcH79+dJa8KjA
         yp0zz6xlvAX4qheZqj9hP5ztGjnQy/tILZMorRZv5j8fJTgZ+XvReZwLITdiJ9qe+t2K
         mx/56gWZ72JTlzxWqloY126OsZ1GmXN+bmQomU1XBN3g2lj3dUrD3bBMmZ4l9Zq3ez2f
         5p4QptUzwe+RIyEMY/nBwLHVW1zgIe19TDE4MIEp0YbxGxEnKDVkmZ6cMd1COm7sgCJs
         RpCxdIujG2PSdn2GCXrq92jfMYBCVdsvXs20vOGnSKTk5cKjck/0XoSl6rCcducDWE2i
         Uk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=A+Lf0Hs68q20LSR1Qh3T82K4UKYgxMMT0FqaabUxcKU=;
        b=X8oAelM3YHl32dcp69SXCXbMfm81BHyccgUVyQeY9vlvZURRGwTDluRBBWC0VEXH0+
         CoCS1F6q7ukdZPD5okrHA7OV+vouRscdazyhCtuzWL3jKPhXJ1XR46I5xfwCr3BzINzG
         O/Ir2XtfulObjc9lzfblPYYxRv3m28k0Dh288RFlYy5Rsdb3zQGL4d1LXyKVkXXKp5HW
         fVdfkJcU6tpI/UcycnBxu+1teB4KkDZkNMf5pJFNFzor5BwpdHzkKCUhX0caWtUwaE4G
         aBnD91pa4r1/euCsAZtlKpqdJQ7CJNrkUWWMx0ytmtIZPE5BtgyyjIVytGHhnMKbNxvg
         F1KA==
X-Gm-Message-State: AOAM5324p+h8VGUbjR2mGiBL2FRjPXfO7gTl2hPkMIinmnwyXMOZ1T4F
        X9mlNEvEH4J6jVBqjoB1oR1lEbwlxeuU9xSSYv47BKpg5XrMDw==
X-Google-Smtp-Source: ABdhPJzj4tkfeHYAyEKjZuTQlZyaWqa66K23lF2/lkdaADiPOMNl0/I1wKnhfxVdwuMlgtUZlKsic2//kP9iJ0Q2SIw=
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr18964387oic.37.1617033329611;
 Mon, 29 Mar 2021 08:55:29 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Mon, 29 Mar 2021 11:55:18 -0400
Message-ID: <CAF4BF-QJ4WRgSQZUS2+amNLX5H5CyvB+C81gQrrB16eh+hqKcw@mail.gmail.com>
Subject: Plumbers / IoT MC Sep 27-29, Dublin
To:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi everyone,

LPC is happening Sept 27-29 this year and is tentatively scheduled to
occur in Dublin, Ireland. However, there is a small chance it might be
virtual again. Things were obviously very crazy for a lot of people in
2020 and it's continuing into 2021 for many parts of the globe, so I
hope everyone is hanging in there.

Likely I will submit the IoT MC proposal today and I'm hopeful that it
will be accepted again. I don't have statistics handy, but I think our
attendance was actually up last year. Maybe being virtual actually
helped in that regard.

In any case, I also wanted to get everyone's gears turning to inspire
others to give a talk. I know that a number of us were working on
wpanusb for both Zephyr & RIOT and there was some momentum to get MLME
/ MAC Layer changes in as well.

If there are any cool developments that are happening, please don't
hesitate to reach out :-)

Cheers,

C
