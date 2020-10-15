Return-Path: <SRS0=JCjv=DW=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D72C43467
	for <linux-wpan@archiver.kernel.org>; Thu, 15 Oct 2020 20:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B965220795
	for <linux-wpan@archiver.kernel.org>; Thu, 15 Oct 2020 20:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBvgGvko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392202AbgJOUQx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 15 Oct 2020 16:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392167AbgJOUQw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 15 Oct 2020 16:16:52 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82EAC061755
        for <linux-wpan@vger.kernel.org>; Thu, 15 Oct 2020 13:16:50 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z1so83110ooj.3
        for <linux-wpan@vger.kernel.org>; Thu, 15 Oct 2020 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pmTKSVtQ/tB16qDQx3xK18DhUlZdOCpgk1USPCfSSnA=;
        b=CBvgGvkoXpSgA+oVqIj45v64t201GeJ38yqlgG1lYz6XFD7AO1VkBGBXeILQ5jL0WF
         Qh4qs+IgoadzWa3yExMrFu/Q3MAB5qVb1wcTgON05ohGeGq2xsDPF16SFSBTQdE+M90Y
         CZ0sHTCPUrZSMD4r/5bbdSoUT+UbURa8E+9tuGI6y5wnRaLe27zFORPnQUpZZ+/UVrhf
         ovGxate/mzlJR+lSunIwEI9mw4TrLpm0E/sHdObMofN1qIKW1rEKk5PSt7RcaiXxaAU0
         0WiBPFVBjSKN/OsVOibme/V6Oyvk8H2zO2N5IDngmAoyG+MxWyf7noyFsQtB56gvk0kp
         Ta9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pmTKSVtQ/tB16qDQx3xK18DhUlZdOCpgk1USPCfSSnA=;
        b=ZWas8mR5jq2x9XCGWML8fvFKr9ySBWvcDc4e78K5XRS4ga8lUsNTSFEg72fCBZheC0
         zqUV4jOOqW1KTtzqz0C/fn5yIvdGA7xHkbEfOsXJPYRk44T3syxL4wUIZnSdriNewZdB
         EyJdJsLzDQ1yp4rPvce8uVbU94a1eNGtMuNslKkq5LetH6MPHpHj466PxhbFb9ymTMZI
         ukqpfgvlrN/z6us8eo9RU1SHZUfoLPB2FL6vWQpz1o4DeFlScHyoTDd5SUxOW9kSpihD
         i7yh8a2FW1yQnn9ZROfxjNKpMu56BWzAaZqA92TKA29H/LvkwT+uOJG8vwOMIIJwFc+G
         LxKg==
X-Gm-Message-State: AOAM532cOJyX6rnUuh74sOzErx/pRXTfuIyRSaXboIdpXnhdENt5L0P0
        16nfwAqbgPCcYnz53WJ03jFnOcjqxkv8yx+sZzUS3pnreZ5y4Q==
X-Google-Smtp-Source: ABdhPJzGJCjwjF1dVyh5a8P8p5+MGLD1Gk3XSb9Tjyc1MakoLVOq6DE4RMe8DBjIA4NceSXIt4ECo9XW5PkoanO7mgA=
X-Received: by 2002:a4a:d0a4:: with SMTP id t4mr170825oor.21.1602793008688;
 Thu, 15 Oct 2020 13:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAF4BF-SFHA=mPHLxpDHGMLvgu0UKO-6ujfYB+n2a6=XhFvT6DA@mail.gmail.com>
 <b009a2a8-64a5-fe66-a53e-5a93135cf1f8@datenfreihafen.org> <CAF4BF-SNRyXQzUBqx5k014nZou4q7=Gd8=dbUyK7JiDkaEEvFA@mail.gmail.com>
 <f98b4515-9570-ad48-2d8f-dcc5482a21a1@datenfreihafen.org> <CAF4BF-SipApoY=7CY8fWs8cSi8rKZaYMxOZHAqoKv=poAgVm=Q@mail.gmail.com>
 <61ffa93d-f8cf-b059-358c-84a6e04b96ac@bergzand.net> <CAF4BF-Re1CoR8abM=hvKN=TojDoLL_PRAJTvjWzB-Ak8tKTvRg@mail.gmail.com>
 <e5d22300-fccc-5a0f-6776-5438bfad57e1@datenfreihafen.org> <0ccbc151-cf8e-cd56-28f8-f1594d226056@bergzand.net>
 <6d787a84-56ba-2dcf-af5c-6f05cec6194a@datenfreihafen.org> <71f4ce0f-5614-6410-9c8b-72a87ab7473d@datenfreihafen.org>
 <CAF4BF-TG4wpX8TdEXY=EeTz4HV0b-nceFwKb=VkFBkMjfSLPew@mail.gmail.com> <e75f3fd8-fa0c-7708-e914-f757965920c0@datenfreihafen.org>
In-Reply-To: <e75f3fd8-fa0c-7708-e914-f757965920c0@datenfreihafen.org>
From:   Christopher Friedt <chrisfriedt@gmail.com>
Date:   Thu, 15 Oct 2020 16:16:37 -0400
Message-ID: <CAF4BF-TYYF_FU7dKFR+VXfYKFUfWes4euLPY3UMOL_f62_4hAQ@mail.gmail.com>
Subject: Re: wpanusb?
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Koen Zandberg <koen@bergzand.net>, linux-wpan@vger.kernel.org,
        Andrei Emeltchenko <andrei.emeltchenko@intel.com>,
        erik@statropy.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

On Sun, Sep 27, 2020 at 4:59 AM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
> > Also, somewhat annoying, but a shoddy USB hub damaged my ATUSB :( I
> > ordered 2 more, so hopefully they get to me shortly!

I received my 2 ATUSB :-)

Here is a question though - the cc1352r supports 802.15.4g (GFSK /
2-FSK / 4-FSK / OQPSK) and does not support BPSK for 868 MHz or 915
Mhz.

Erik confirmed today that our wpanusb solution is working today both
at 2.4 GHz and SubGHz, but we are using channels 0-11 for SubGHz. I
think those are reserved for the BPSK phy though.

Do we have pages / channels that cover the 802.15.4g PHYs in the wpan
stack? Are there any suggestions for which page / channels to use? We
have been looking through the spec, but of course it's quite dense
nowadays.

Also, since these radios can theoretically work simultaneously, we are
considering exposing that as two separate and simultaneous PHYs and
data paths. Is that something that would be desirable in wpanusb?

Cheers,

C
