Return-Path: <SRS0=c9gK=CG=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4DC433E2
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C50420757
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNsBIpcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgH1Ogj (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgH1Og2 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Aug 2020 10:36:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA5C061264
        for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2020 07:36:27 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c6so982901ilo.13
        for <linux-wpan@vger.kernel.org>; Fri, 28 Aug 2020 07:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gL6R18tgQ0MMUexu6CpP4qho43LK7r1mhi2FfAO7ZI0=;
        b=hNsBIpcNDTdEk1rS5RaUnCwrtZvOxXm4oAitFPrbGTsUgjppKUbzyh68VDG6/5u4rI
         jvtEGIYezMXw5vPiFSS60IsXEeaXu+sSbQhjCUzqSFU4ubJ5Y8BJmlnwICT16IDY8W3x
         lBMPUObLoUqwmUDJOtEX6yb2e3bf8vrUpw/zEe1sekaHQeOqJvA0UKnVqW9K/j0HaKhj
         Jna68AxPtTCVwdL3Z+1/OFfC7ZDXFXY81YgVCeWpDi3kGbTahXya86WbitB0datyK5fi
         wnqbBKYseBgSdnLMH3x2ANtDSuxRMmlOOSOeKSVZLaMLQiONZr69PYYRkFQ4Vo05prhH
         yMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gL6R18tgQ0MMUexu6CpP4qho43LK7r1mhi2FfAO7ZI0=;
        b=lXcNhidqdew9N4Mt2FhlapldN55dPEt64Ah57mluwuQtScu2U8h3X7YcX2Jg2/xarr
         VXJ7hpzMDeEnQ5ZTM3CDR5gqhQQe6wSIFSxioF44a4Ob5+CLY644xcClRJXMT/D9EyRT
         k2yePszc+2oY96c/x6QnHgIYBic/Eb/GTgWml/uUTIUJFE7L/0+EOrb8EotI8RhJXlvh
         CfaZkFQHOFmzXnc6yQ0zRjtfyt6ZU6TyEHEVdIRxAAkSheaDvk3/5Jg4EwzgD8AboPc8
         ecfG639envvcs/FGQDnjAz2XXU4hFqdtIhyuJ9lwh3JGc6302itFmYwrVs2/sffXQtRs
         SMrQ==
X-Gm-Message-State: AOAM532GsPEJ20Ba2iOd1JgEz4pSkjIPwx9gfVYNGKwjnNZRCdLFfhsj
        kg6FirYoGeVW6zFzPl0lJtXMtS706sqHwx4TqqS9dpeg4YToOg==
X-Google-Smtp-Source: ABdhPJxbFfnIca64FIzABEJ+8xNgk2FyarUfzDU2Ja4PNxuDhSeRidv5+fyakshB6hsE7S9XUHNOnvFZcMZzv2XmaRY=
X-Received: by 2002:a92:c80b:: with SMTP id v11mr1534826iln.91.1598625386815;
 Fri, 28 Aug 2020 07:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-TVe09FUdWZLw9dQf1=d0q-2w=Ey7LXx61rHBOtvczmBw@mail.gmail.com>
 <20200828142616.GI5022@ni.fr.eu.org>
In-Reply-To: <20200828142616.GI5022@ni.fr.eu.org>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Fri, 28 Aug 2020 10:36:14 -0400
Message-ID: <CAF4BF-SikcubXWuQXEm_cieN08d+8_ZKjvNhtGwOmwMC7OSZDw@mail.gmail.com>
Subject: Re: MAC Layer Beacon / Scan Code
To:     Nicolas Schodet <nico@ni.fr.eu.org>
Cc:     linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Michael Magyar <michael.magyarm@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Nicolas,

On Fri, Aug 28, 2020 at 10:26 AM Nicolas Schodet <nico@ni.fr.eu.org> wrote:
> We are working too on the same kind of features, I am =E2=80=9Cni=E2=80=
=9D on
> #linux-wpan. For the moment, we have a quite advanced branch for
> scanning (active and passive) which tries to mirror what is done in the
> 802.11 stack, written by David, and another branch for joining a PAN
> by Thierry.

Very good to know that this is a feature that is of interest to the
greater community.

> I would be interrested to see a rebase to better understand what you
> have done.

Should be available soon - possibly a week or 2. Need to set aside some tim=
e.

> I asked David to prepare a branch to share so we can see how to move
> forward.

Thank you!

It's quite possible that we have duplicated work, but such is life.
Let's get these features in soon!

Cheers

C
