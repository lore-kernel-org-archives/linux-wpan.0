Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89012C2B9F4
	for <linux-wpan@archiver.kernel.org>; Sat, 19 Jun 2021 11:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F7B610A1
	for <linux-wpan@archiver.kernel.org>; Sat, 19 Jun 2021 11:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhFSLhv (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 19 Jun 2021 07:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbhFSLhu (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 19 Jun 2021 07:37:50 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1146C061574
        for <linux-wpan@vger.kernel.org>; Sat, 19 Jun 2021 04:35:39 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w1so765615oie.13
        for <linux-wpan@vger.kernel.org>; Sat, 19 Jun 2021 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=x5HrP36gO0ALn9u29sXSbHdTWm62qTUICdR76n9yB/M=;
        b=qfyno8OX68b9pxiY3AUAvfsIq2NyMCu6SahEE4S0bSx92e0LY1+dbXapw6Jz+3uBpc
         vvtcs9fwMiri69umkSyhsjS3Si24HJ5oXTva1PBloe7bUDW98aDP9VWuRKnQXS3RdZPn
         OLNqafmwFufmaDrdUi3r/+sYEyfxVIFa+nVdRjgFIMPWFgJNhhRIWHLuVSSKUbIPjOiv
         Ze7Ksvfn3Nv7fwKq/EQJ/9oAWgp9Y+dR2zo22Oxaz5U3RKrjNoQvd2ZNEFjF1u8NOHCP
         ZxbHkHyOV/jXL+nQP73NXPe9hyV7IK3+i0bfZyj2q0H/G3VIgAsGML3e+/bg3fX/rlK5
         gDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=x5HrP36gO0ALn9u29sXSbHdTWm62qTUICdR76n9yB/M=;
        b=hZUW2SRPNDP9a85PHShyhIdsMJPG3PGwwCKwU7MZ21WoRPtlyI3HwOdAMoVgWbaW3a
         Z/nv2qnXSwV8aaZuv0MTEAloNKxtolmgrfKPVzfmSfqEX9Vony2LaRINZY4eOty/HiAK
         udcq1+4uhqQ+B11E0rFKoeWvE+fU/+XQHhF8KlwHIqZF/PZO4HzGEhAsm+CORR54LNGI
         xZ75b0tCWExXwRadm1iGmg07n8FkO9HAb/z4NRY0DyCjkBs+JrqMTTsLWwxD3j4yVNwZ
         +Yby+K/DPuxdO9uL38+vwFBR0s8PjguNG6LSbLRPYFR8NKOdTb5FcQYTFpYWwUX9zdGj
         +RKw==
X-Gm-Message-State: AOAM533GYyeVK5de/cy+DnMD/UuNAtYcyX48cJSW87+rm+8C7f42klaK
        sxAU7A9nkEpVyPHZr6rIcFQTErvmN9wOBYBqIoOt/9JRdEQIDg==
X-Google-Smtp-Source: ABdhPJzDS6pNmTfyn2dwFVNfIUBnd0+PwH9OTcW4RVQLW99Qx4ETNAMCUpc7+L9AIibEn/vFd2xu0Ai1mOcf3+Khx6k=
X-Received: by 2002:aca:7541:: with SMTP id q62mr17780488oic.37.1624102539053;
 Sat, 19 Jun 2021 04:35:39 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Sat, 19 Jun 2021 07:35:28 -0400
Message-ID: <CAF4BF-Qd9nenMGO2mQv8PCHUfU5aRaMHgdGyo51YDx+_wgZQPQ@mail.gmail.com>
Subject: Linux Plumbers IoT MC: Call For Proposals
To:     linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi everyone,

The IoT MC (IoThree's Company) has been accepted for the 3rd straight
year at Linux Plumbers, Sept 20-24 2021 (Virtual).

I see lots of great stuff happening here and would like to invite the
community to put in some proposals for IoT-related talks and
discussions.

https://linuxplumbersconf.org/event/11/abstracts/

Just scroll down to "Submit New Proposal". In the dialog that appears,
under "Track" select "IoThree's Company MC".

Tell us about your successes and frustrations about bringing-up IoT
products in the Linux ecosystem :-) We want to improve the developer
experience for everyone and discussion is very welcome!

Looking forward to seeing everyone again this year virtually.

Chris
