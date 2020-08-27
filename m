Return-Path: <SRS0=KPv3=CF=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC6C433E1
	for <linux-wpan@archiver.kernel.org>; Thu, 27 Aug 2020 17:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BE920791
	for <linux-wpan@archiver.kernel.org>; Thu, 27 Aug 2020 17:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trXHqllC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgH0RAE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0RAD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 27 Aug 2020 13:00:03 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A751DC061264
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2020 10:00:03 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id o16so1511230ilq.0
        for <linux-wpan@vger.kernel.org>; Thu, 27 Aug 2020 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6mq2FEi+WqwW7ZVXUBQUyw7vCnNJsuOO4NMyDxtKng8=;
        b=trXHqllCLMpceQkqJFwaIf3M/aHMzS+10nKhTc59s4aC6eNCPC0yXPWeRId7K/DEu0
         hAa5c4MZK6ob5l7QBCiSIIAjEynsmEDVHjEcvBAfEXgllT9oEVtHVKDA4aPNuBNlwuFh
         UCE3KsCeqA4ubb3t/6pmDVIT4yUUR7ld2o2a4YerbrWfToBdP2JAHJpxVNrjW/EvESIz
         v3edx+j6P2VkGxw2uS96r82U9gFVLMlB/gjQ/Vg4t1xPoSFwgNZQfq4kc+1UARVCaiTx
         MUxXrIbZRsjofp/KVCKa8+nIUDUWTI1pLM9H/iztB5pKgy9fapaoC5Uwp/ACS9gvDCPP
         R1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6mq2FEi+WqwW7ZVXUBQUyw7vCnNJsuOO4NMyDxtKng8=;
        b=NpNgjuBz7mT6ylLzz/LwMiPlmUd0QnX88YVJRKMGLweMSSlzZdIhR04D59kznlGPi2
         ehJLOnHKzRxWuh2wyvGJcorMUhR1nBNEyMUTyudTndueM7L7j4kBByGW7O3vmG9H9ytV
         peyZ8IOnCVJ4z2xyHGT+Rh6AOcT6UfAQp28IArbh3FgPwC3OQFXzgoloc5wdYzU2EPX8
         6/a3OhGNpKQhDPI1ql5iVyhUJyFfRnRY1DIyHOZCfJL5YQO9L/F1pNGan7Br/xo6HnA3
         NrrdcyIwWRfeflzoRygmj0d+JoxjiI+5l2jxWR92mWQi6vQzcQ7O1Rr0WRBtUZeQ3B5i
         OuTQ==
X-Gm-Message-State: AOAM531aL0OqADlTPauFTHh7NwZcqUoj5A93gHEPqPj9uKnOCoEFgueG
        wX77CtBcuJTLow3WLGHQtHHbrRhQ3xPwhGf5TNC7H2FaEW2Sew==
X-Google-Smtp-Source: ABdhPJz5xK8ryrrInXk5d2ui1MPw8ss/VA9xdZWv4b6JSGBdWYdBy8rFiDBS4Ca884GyWaseCiRfvCyEfkXzjrby9Yw=
X-Received: by 2002:a05:6e02:d52:: with SMTP id h18mr1437472ilj.215.1598547602141;
 Thu, 27 Aug 2020 10:00:02 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Thu, 27 Aug 2020 12:59:51 -0400
Message-ID: <CAF4BF-TVe09FUdWZLw9dQf1=d0q-2w=Ey7LXx61rHBOtvczmBw@mail.gmail.com>
Subject: MAC Layer Beacon / Scan Code
To:     linux-wpan@vger.kernel.org
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        Michael Magyar <michael.magyarm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi everyone,

I thought it was lost after I moved on to a different employer, but my
former colleague Michael Magyar managed to dig up some work that we
had done back in 2015.

I unfortunately do not know if my branch still exists, but it looks
like his copy of it is still intact.

https://github.com/magyarm/bluetooth-next/tree/feature/nl802154-get-active-scan-req
https://github.com/magyarm/bluetooth-next/tree/feature/nl802154-beacon

We had some additional changes for wpan-tools. Hopefully we can find
those as well.

These changes should allow us to create something along the lines of
Network Manager for IEEE 802.15.4 or even to do some automated channel
joining, etc.

Let's keep this thread open and try to rebase patches & get some
patches posted for review soon.

Cheers,

C
