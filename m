Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A17CCA473
	for <linux-wpan@archiver.kernel.org>; Wed,  1 Jun 2022 21:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiFAVsg (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiFAVsg (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jun 2022 17:48:36 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651B8138B78;
        Wed,  1 Jun 2022 14:48:31 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p8so3107276pfh.8;
        Wed, 01 Jun 2022 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+j/j6ZZcvT2tG9PIt5jSStCPIw8EMJF296f9+fp4xk=;
        b=QiV+SoVT+7RDqwtcK3p/Ag7A49ajVYHRyjInvVrE+ZGzSX5BZPtW+vtc2lE8Y84IwG
         CD62exlqS5vhxgKqvBeRAmypZa13Yjm2WTOBVQxrNqXC2RdRAiykTt7E+USkpWhtbh2R
         CMlshdH8HdKkj20FsQdEoGpsUMLfNSP8/8Jkm6JkrOHEOtk0fppikAWPY0dwSRZhg7Jl
         iDEGC0WTZGnss2Kbc77E0EHEiF+N3NDcYBniKRmzUXqxbpwUa7NV9XN8955Gn0caNDrm
         awSgSh/wExkrOIiqUg05Trdm3xFAghnwERrgxb+YaIMqQSfxoNrRGDWScX9wyruikOZl
         LeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+j/j6ZZcvT2tG9PIt5jSStCPIw8EMJF296f9+fp4xk=;
        b=hZhiouWvCgWrwjQsYBltzMMVM2LI8iIy4SVHykg6SkTHwDUYRAUKoFiaO+QP72RB3m
         ukSwv+KbwWAYwwULYh/ZuaeGFlZaahyY0W6I0T2lj22+MUtGVTdwCoFzRaLTl1IHwElz
         9pUQsT3R313eOH+2Z/E6Wc98eow1OH7s6VSr4LIwhDaZ65pwfd/dEIR+UhzAkxmVGNT4
         bngWX76RExn3v3QuDJAKIszL7wKPaGHKm738jVtKeAIAx9bpT1hk/z8yxB1vofvkMSPt
         mgh/B3qZaw6Oxynt7O3jm97/usSV4k46EYhnY1k6es3gN95S85citRqfWpILChzHgIv1
         NXMQ==
X-Gm-Message-State: AOAM530AUNvbkPI8hn4Ei/Jpn8Tu4uIRH5YuIE744yKj0xwPqSxmvHfA
        xXoFMHjw7GsvIO8XVxx2+hTRzpHiKJtZJBlRPKk=
X-Google-Smtp-Source: ABdhPJyQhJj8zhj19F7GxI8Oj/0ApFN96qTqcsXb4yAGSygWr068t64O0Y3kTBb/KnsKV8r+jYKLEioMnrI5LBAFgM8=
X-Received: by 2002:a62:3001:0:b0:51b:b142:88ad with SMTP id
 w1-20020a623001000000b0051bb14288admr1619585pfw.52.1654120110918; Wed, 01 Jun
 2022 14:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220428030534.3220410-1-aahringo@redhat.com> <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
In-Reply-To: <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Jun 2022 14:48:19 -0700
Message-ID: <CABBYNZKCoj+W1MygU4eZZxGVSrWuRfEWx-fLOXvV-vXXY72vmw@mail.gmail.com>
Subject: Re: [PATCH bluetooth-next 0/3] net: 6lowpan: simplify lookup by nhc id
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Alexander Aring <aahringo@redhat.com>,
        Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,

On Wed, Jun 1, 2022 at 2:37 PM Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>
> Hello.
>
> On 28.04.22 05:05, Alexander Aring wrote:
> > Hi,
> >
> > this patch series removes the rb data structure for looking up a nhc by
> > nhc id. Instead we using the existing nexthdr lookup array by iterating
> > over it and find the right nhc by nhc id. It's simply not worth it to
> > use such complex handling for such small amount of nhc. As we only
> > support nhc ids which fits into 1 byte and there are not two byte nhc
> > ids values specified yet, we let the nhc layer only handle 1 byte values.
> > If there is the need for 2 byte nhc values we can add support for it.
> >
> > - Alex
> >
> > Alexander Aring (3):
> >    net: 6lowpan: remove const from scalars
> >    net: 6lowpan: use array for find nhc id
> >    net: 6lowpan: constify lowpan_nhc structures
>
> Marcel, Luiz, are you still picking up generic 6lowpan patches or only
> the ones for bluetooth?
>
> These three have been around for over a month and acked by me and Jukka,
> but I can't find them anywhere in bluetooth-next or Linus tree.
>
> If 6lowpan is of less concern for you I can route them through my
> ieee80254 tree as well.

Up to you, I was not aware they normally were merged thru
bluetooth-next but I would be fine merging those as well.

-- 
Luiz Augusto von Dentz
