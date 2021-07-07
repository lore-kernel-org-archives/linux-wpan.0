Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C3EC07E95
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Jul 2021 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86AD261C2F
	for <linux-wpan@archiver.kernel.org>; Wed,  7 Jul 2021 18:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGGS6M (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhGGS6M (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 7 Jul 2021 14:58:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DCFC061574;
        Wed,  7 Jul 2021 11:55:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q17so4264876wrv.2;
        Wed, 07 Jul 2021 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rIcObNLd7s+FRLMO3PqqfpFjzPcy3noifal9uAYzz3s=;
        b=SX2BtohmVhe1TwjMyy09EFvKYANQWJ7vJvkRHa2ychxQg6KlVchjeRXYnmbY4Uk0sP
         JqSGn1LLQxzNgZyKmV45cGPp7p2Ve2blMq4bfXdQ+RDUuXSoF5hrAy/LZOFvrJ92QVEw
         QXSkQU20dPElQHddSarmRcENaR8LxJH54sSF4HYrV8NEYSE2XlgmGZEWqhimBxrwNLK6
         h1Nz6e3jR5CyM86p1MpOJG+VLqreWTk0HiFbh/W0stqTGSxCAgttVkgbv6p+DZV4lgqY
         QNoBro+P+/OlQBUPhG5tCKL20wbJl3YQ9dYveMa+paZRyDjuAFLClnLbgO03oYaniUQf
         Y/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rIcObNLd7s+FRLMO3PqqfpFjzPcy3noifal9uAYzz3s=;
        b=U08ZaaFgNV/+cpOliRrUwGc6Ns9g53Jis782743+DSfi+K4ls18+Zv9dwfMKPMgs4w
         f8tiX+nYKMlmRjZWJEoj3SJaTenSRT24xS+LqZdkd3kCCpTKnipoG45Yh46awuIWM/Mo
         iigfGkMdnIhyBBkcQx0xOFfNdhF/Xc4NhQ1dqCtyqmeM4WKQCylMtsKxcikywJbMJID+
         TdpKQ9INZ69wW5FFDESZUtJX4qMv4mFbhrcUo6RN/ewzOiQYxP6iD2gFJvScaLmdu8om
         3VXwAIyKDWW9HrDAGi7zLXkvoEXeLvvdkGbCIGRpKnTFMg3BGey3a4NUyOFs4yM5sGcw
         gmOg==
X-Gm-Message-State: AOAM532gOW/YzEwktWsQ/JbGV1QIUolhnNUcAILDbRdHcer2RNF9U5UZ
        CUEIi55H4wnj2E8kPCzKd+zy1Ch0QWdVAi9NfXY=
X-Google-Smtp-Source: ABdhPJx8wQid8fHVIWF+ZlF3WzAhn+fV1ZO3bF07jpFGw2e2rMN6C/6Z9wPp+bmaQ0Zj0tpLVzcbHd0PEuxRcifDdPc=
X-Received: by 2002:a5d:46c8:: with SMTP id g8mr5129560wrs.341.1625684129925;
 Wed, 07 Jul 2021 11:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210707155633.1486603-1-mudongliangabcd@gmail.com> <CAD-N9QWZTRWv0HYX9EpYCiGjeCPkiRP1SLn+ObW8zK=s4DTrhQ@mail.gmail.com>
In-Reply-To: <CAD-N9QWZTRWv0HYX9EpYCiGjeCPkiRP1SLn+ObW8zK=s4DTrhQ@mail.gmail.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Wed, 7 Jul 2021 14:55:18 -0400
Message-ID: <CAB_54W6VkOQ+Cf4gmwzJyQpjyK5MRqsGXkQD3fPa2UC2iLudtQ@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: fix GPF in hwsim_new_edge_nl
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Aring <aring@mojatatu.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Wed, 7 Jul 2021 at 12:11, Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Wed, Jul 7, 2021 at 11:56 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > Both MAC802154_HWSIM_ATTR_RADIO_ID and MAC802154_HWSIM_ATTR_RADIO_EDGE
> > must be present to fix GPF.
>
> I double-check the whole file, and there is only one similar issue
> left in Line 421.
>

What about "hwsim_del_edge_nl()" line 483, I think it has the same issue?

- Alex
