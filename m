Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC72C433EF
	for <linux-wpan@archiver.kernel.org>; Wed,  1 Jun 2022 21:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbiFAV7C (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 1 Jun 2022 17:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbiFAV7B (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jun 2022 17:59:01 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774E99FEF;
        Wed,  1 Jun 2022 14:58:59 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 137so3070745pgb.5;
        Wed, 01 Jun 2022 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3g0ZBaTIRhPF2IzSxhAXB7VBdUwjzUT6id3bZr6aR48=;
        b=jz+ELaBwzlFPdo78BC3K2yfmW7PiJUL47L6SAtwq6gSJr21xzHeURllb0x5BVMISqO
         ODXma0Cc4rx8zuW32pTv5CDo5BzW5W9oCAAEjHjbHiPnVQ8Rc71KI3WmlQYjy4Ak1avq
         CMaBjvJEz1mz1pyYnq3UfYGH1dymHMAC8c2a8gOZcjenK6aOg0elOKhogVvxNSSfFBdz
         qTjceesVPi0BkpI+gbTWmPRsTu+dod9EVHmt7/OaMRhpTvikj+qtPF8x4ngqfETWuHFv
         oil51RBsT8DvELud+pJE8n5xhWKSBVLhKelma9k2tk/w9vshVK6Qx06uig7F50udFHBM
         W8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3g0ZBaTIRhPF2IzSxhAXB7VBdUwjzUT6id3bZr6aR48=;
        b=QmzuleEo1V80doHh2ckj2H6P5pX/qIm7wx6gZSzvXJ2ogvPYb+fc6GhTV9slsFLyMZ
         r5S/2rS1riaNu24PNo0RIno+dQ3ZT16g+xMy+y94C1UCzN1rp8EIQHyYHfEXUbxg9AWW
         w5R5lvP0fDh6w7FhYPfUZ/+ijs6gYhvlB4YcmYrJBJXs+zCX1XZYL40FdSyPueSmpWbR
         0APK2jGQo/FS/KKibmesYvf+7cYRPKio2sQE9etRoumBVoB/zjEIAZ1KJnV9tI3OYZf2
         3SJ6749P2Be++wG9tntGlPIzsAWJKHeyYk7xsosWzaO2PBmBB5RabA0YALLf+j8C+vfM
         GQlg==
X-Gm-Message-State: AOAM532KnT7B+wSiJQv9hgYcQLs7jMHT9jGTrU4bMWVzGgWNpEmYj/H7
        i7mGpeRlEL1+/Fa+pYf0Jp9Z0NjsKkjXZE2cc7U=
X-Google-Smtp-Source: ABdhPJwiv9pgYXYSdXaQlefbOZpD8mj6sB1UEUXPFNIYL0R93YF3CozVEw6YTuv29DqHburvRK1NhTft9lxkp/w6+xM=
X-Received: by 2002:a05:6a00:889:b0:510:91e6:6463 with SMTP id
 q9-20020a056a00088900b0051091e66463mr1650906pfj.58.1654120738948; Wed, 01 Jun
 2022 14:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220428030534.3220410-1-aahringo@redhat.com> <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
 <CABBYNZKCoj+W1MygU4eZZxGVSrWuRfEWx-fLOXvV-vXXY72vmw@mail.gmail.com> <3b5d28c4-1877-ba8f-dcb3-d5c3cbc06a1f@datenfreihafen.org>
In-Reply-To: <3b5d28c4-1877-ba8f-dcb3-d5c3cbc06a1f@datenfreihafen.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Jun 2022 14:58:47 -0700
Message-ID: <CABBYNZK1uWjxmvJUBPaUdMvj8B-p=TtRKTUwQ0szCgLhh+7CcA@mail.gmail.com>
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

On Wed, Jun 1, 2022 at 2:56 PM Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>
> Hello Luiz.
>
> On 01.06.22 23:48, Luiz Augusto von Dentz wrote:
> > Hi Stefan,
> >
> > On Wed, Jun 1, 2022 at 2:37 PM Stefan Schmidt <stefan@datenfreihafen.org> wrote:
> >>
> >> Hello.
> >>
> >> On 28.04.22 05:05, Alexander Aring wrote:
> >>> Hi,
> >>>
> >>> this patch series removes the rb data structure for looking up a nhc by
> >>> nhc id. Instead we using the existing nexthdr lookup array by iterating
> >>> over it and find the right nhc by nhc id. It's simply not worth it to
> >>> use such complex handling for such small amount of nhc. As we only
> >>> support nhc ids which fits into 1 byte and there are not two byte nhc
> >>> ids values specified yet, we let the nhc layer only handle 1 byte values.
> >>> If there is the need for 2 byte nhc values we can add support for it.
> >>>
> >>> - Alex
> >>>
> >>> Alexander Aring (3):
> >>>     net: 6lowpan: remove const from scalars
> >>>     net: 6lowpan: use array for find nhc id
> >>>     net: 6lowpan: constify lowpan_nhc structures
> >>
> >> Marcel, Luiz, are you still picking up generic 6lowpan patches or only
> >> the ones for bluetooth?
> >>
> >> These three have been around for over a month and acked by me and Jukka,
> >> but I can't find them anywhere in bluetooth-next or Linus tree.
> >>
> >> If 6lowpan is of less concern for you I can route them through my
> >> ieee80254 tree as well.
> >
> > Up to you, I was not aware they normally were merged thru
> > bluetooth-next but I would be fine merging those as well.
>
> If you and Marcel don't mind I would like to switch this over to being
> merged through ieee802154. Mostly because 6lowpan is vital for the 15.4
> work we have.
>
> With Jukka stepping down from co-maintaining this part (thanks a lot for
> your work!) this will most likely be reviewed by Alex and me anyway.
>
> We still need to ensure that patches are hitting wpan as well as
> bluetooth mailing list, but the MAINTAINERS file handles this already.
>
> Let me know if you are unhappy with the switch. If not I will start with
> merging these three as well as the MAINTAINERS update from Jukka.

I have no problem with that.

-- 
Luiz Augusto von Dentz
