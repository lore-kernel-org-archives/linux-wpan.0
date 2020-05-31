Return-Path: <SRS0=ofrl=7N=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B166C433DF
	for <linux-wpan@archiver.kernel.org>; Sun, 31 May 2020 16:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA9F2074B
	for <linux-wpan@archiver.kernel.org>; Sun, 31 May 2020 16:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuLicpB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgEaQN3 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 31 May 2020 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgEaQN3 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 31 May 2020 12:13:29 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A02C061A0E
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2020 09:13:27 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k18so4484213ion.0
        for <linux-wpan@vger.kernel.org>; Sun, 31 May 2020 09:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bw/H7QoV8NHn/s7KdcXvsc20GBzOrcKatAEWro6ZLsQ=;
        b=JuLicpB/MIjhO1Kp8UjUgP5+K+DDcdxYR5HLfTcx7c+fni2p0xfTZR9wcB05PRiuwR
         5oON4LanOTUSfnO5bvW0mzN9rS6qoNKhywpL3gTph8cUrmukFF5zXe5CmDXfnQYFskOK
         L5AU9MvKcL29bAdBQPSW3Wr5usGP8vYPOACm5bno/2gR+BbN5ze7vPhGc69StEC6akq9
         oLpSQy7ff8f3W03zIUW/nMC8j2i1BCbevq/1wvlUKvGt2Tg/MVZwHQsYdYFIR8BwIOMP
         A9ml5zGN9cMkpbV0pAgjXuA37ivoiKBXOYD/p3Zr8DHXxuzkEN9ueTFF7Dhrai7pT6J3
         vBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bw/H7QoV8NHn/s7KdcXvsc20GBzOrcKatAEWro6ZLsQ=;
        b=nWC5ifFlgHQweDhdafqMHIN7VeUvjYm637ww2yOaBpZ1Y1cWJtWlV+2wDihlQwA/Do
         IEKX4t4TTuAm5PPyiW7RzboFi6cNCPpste1ZtAJxxFQFqsxExDPhHnbESCFPjHH5rBmN
         7jyMVc8sWf896ZQkHWaCvuUjT7pLpoBy2drX5rhAbDqiZ2PAdqGI/jtQ9gx6c0eBlLf1
         ZFcK3+MPOxKUzZ/KCBElzwRc0E4O+L9OBNGWZTXmY5dE9pHaEo/mLaDONYMwpum6MWlu
         jWtsr94W+DbJk1ZcPB5nyaOcxw4PkrvzylZQsmI2AX0RbBiDQDBphiGDSIWdh4RyfsB2
         HKoA==
X-Gm-Message-State: AOAM530X2OfGdZKkb9LH0N8f9UI+SGUSbJsBffx4vfpVUHcX873ucgV7
        m2SMrpykcyjXmsPR6YwqkWbihNzpErFY6PWRuXusCyr4
X-Google-Smtp-Source: ABdhPJxyNrwfCNr6JnHDSxux6uRFFw4bXFDJeDJ1r+HZYgs5hVkjUpNhzRWjmQ09SXdTB/8PILoO1yagFuvL1d2fw9A=
X-Received: by 2002:a6b:8d44:: with SMTP id p65mr15310339iod.24.1590941606963;
 Sun, 31 May 2020 09:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org> <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org> <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
In-Reply-To: <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Sun, 31 May 2020 12:13:16 -0400
Message-ID: <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
Subject: Re: wpanusb?
To:     Koen Zandberg <koen@bergzand.net>
Cc:     Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Koen,

On Sat, May 30, 2020 at 2:10 PM Koen Zandberg <koen@bergzand.net> wrote:
>
> Hello all,
>
> Long term RIOT maintainer here.
>
> I'm willing to work on this for a RIOT implementation, assuming there is
> some documentation available on the USB protocol side :)
> I think I should be able to get a relative generic firmware application
> able to run on any of our hardware boards as long as they have a radio
> and a USB interface.

That's great news!

Also, I heard from the original wpanusb author and he said he'll put
submitting a patch any day now.

Cheers,

C
