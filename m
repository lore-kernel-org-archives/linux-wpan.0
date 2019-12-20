Return-Path: <SRS0=/weu=2K=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F0C43603
	for <linux-wpan@archiver.kernel.org>; Fri, 20 Dec 2019 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553620866
	for <linux-wpan@archiver.kernel.org>; Fri, 20 Dec 2019 23:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YybQpdXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfLTXGt (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 20 Dec 2019 18:06:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39107 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfLTXGt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Dec 2019 18:06:49 -0500
Received: by mail-oi1-f195.google.com with SMTP id a67so5477164oib.6
        for <linux-wpan@vger.kernel.org>; Fri, 20 Dec 2019 15:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+wwp+DwXzDQhsjm/xUxuWpGp8JPeYIcai0/6PfJyxE=;
        b=YybQpdXnp7HScr7FGvcvwB5yfdWQ+1xAQg0UgK4mXgl007diAoaBoRCGR+LCKVex3S
         ku5YW5NWO/YhItRgmclak23dGIU3A2JsNQsuAlqVUKuX6Brjr2hcEMKXtmIKDNUAeqz4
         HML/ECpjavFIGkQ1uOyhOiA+7Jt+Llt22HsL5issSfZkDFnZb2AykhHh0ksbubMk9ify
         vAzZPV/aYqXTXmjtWLIrC3vAmb0fpHH5zZjaG1fviNA4uee9IP+Ph9a5rZ+m/2mSh7GH
         IZHbo5atErA8eZGc715/cqnfdIzT9c2E0OT3a2/bNl9ZXTL1Ka2Rf2AU6skG6pV2vIOL
         o7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/+wwp+DwXzDQhsjm/xUxuWpGp8JPeYIcai0/6PfJyxE=;
        b=mVqs9nHFNT2EBsQMD4cC0gSfZcSJXJRDf+nTWLD1suV5h8FSqnCmbGmLJ7Wdp3LmV3
         LO2RnEpbqGYVtms8YQiVq4VSpP2NzioSOjPBdl26p1tVUFYpgftszqRIKpAFtXwXajRI
         t5SEJpTgCTc4hXdVoWFhdiW/6eYBSYgGEVIZ1I0R+jcAqWg0usSmXLRr7dSPnvKUb0BH
         mnkcvKetghnwGLz2jeAxhnUreEdhx2CyJM4lX2x0duMDnXO3XbdHJndyEoTMsHh3Dnfo
         SoAbu3ipyZfQ74SDmiHwiJOoYmQ+jQa7hZD6eOfvvC6O0vpaOAwftHvt0S74FxjHJ2NL
         2jYA==
X-Gm-Message-State: APjAAAUdce3TNhW3dYRTJBiaNPbay1kPIQHr4PMdHraBXfvYKR10rS5H
        Zj3qzW24JS6nbfRi18aFy9GK95Zjm6HoZFeB6c2SmA==
X-Google-Smtp-Source: APXvYqzh7dnCRxiZiYQXctUGQmxoUNf1J4JOx+7H6G3k3EFGLfdwmYgoptaJZFltkaRTwC0esz840/5d9E7UZa2A4tY=
X-Received: by 2002:aca:c492:: with SMTP id u140mr4609377oif.80.1576883208562;
 Fri, 20 Dec 2019 15:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20190918195819.7492-1-stefan@datenfreihafen.org>
In-Reply-To: <20190918195819.7492-1-stefan@datenfreihafen.org>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Fri, 20 Dec 2019 18:06:37 -0500
Message-ID: <CAB_54W5g137YQJRoVUrUF1ELoP_s1SWhocQ2sPLni6moHc4Tdw@mail.gmail.com>
Subject: Re: [PATCH rpld 0/6] Mixed bag of rpld patches
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

On Wed, 18 Sep 2019 at 15:58, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> This series does really not have any theme, besides me starting
> to look into rpld and playing around with it.
>
> I had to fix meson for my lua detection and make sure the ifdef
> for SCOPE_ID is honoured. After getting it all building locally
> I added Travis support and submitted builds to Coverity.
> Afterwards I did a quick run through the reports from address
> sanitizer and coverity scan.
>
> Not sure if you would prefer review for rpld as patches here on
> the list or as pull requests on github. Up to you.
>

I can't deal with the github gui! I click always the wrong buttons
there. Thanks for setting up this travis support, does it work like
wpan-tools to push it into branch "coverity_scan"?
I would like to review patches via mail, what do you prefer? What is
the procedure when somebody submits pull requests on github then,
somebody of us send it via mail? Sounds more work... Can we do both as
"whatever you like"? Can github somehow send pull request via github
to this mailinglist? Would be nice to have something to connect the
whole github thing to a mailinglist and you can control it with that
as well... at least the commenting system but I think this isn't
possible and the new kids wants all pull request via github gui. We
didn't answered this question for wpan-tools as well and I once
clicked the "merge" button (actually not by accident).

Also how we do that with signed off by thing? I can still fix it
somehow what I did there...

- Alex
