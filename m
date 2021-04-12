Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE28C433B4
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 12:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E240C61263
	for <linux-wpan@archiver.kernel.org>; Mon, 12 Apr 2021 12:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbhDLM30 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 12 Apr 2021 08:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbhDLM3Y (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 12 Apr 2021 08:29:24 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC10FC061574
        for <linux-wpan@vger.kernel.org>; Mon, 12 Apr 2021 05:29:06 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 25so11745060oiy.5
        for <linux-wpan@vger.kernel.org>; Mon, 12 Apr 2021 05:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd+Dsf274cpm38W6wCPQUhnEDZnZmiaLlN3BFxdV/t8=;
        b=kkOhtEDa89cYXZ1pZ/qTcGA7cP6uu19CGmSlpz4cM+1AbUYqCfXwzvrtS1vHRxK+jc
         szLomY5Ubum+GqAJpb8NQrAJb83i/0ODnt6t+RLq6xURy7yYF6mOVwOXsuw+3iXfdbDr
         7hi3AFd3V0UEbBmly3EE66rhqTcqDD3LKVxlZ6fXNfn3U6eQZBCqx9rKfGeNz9+ntHXh
         6vs5RQE3Gq6oojvzius3DaC6rnJNm+lKJMIdaVL0Rwmo3YElVEP2dEA0YQPemdeAiMYh
         KNFt4Blpoc9A9diEnPv5Yz0Ay/1GeBweO4jVgaN4yDoX0QByX/TsVd3Y+yMAf0ogYcwC
         ssHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd+Dsf274cpm38W6wCPQUhnEDZnZmiaLlN3BFxdV/t8=;
        b=sY2Xpa45scAHg0B3rwLd0AHhhlftFXufutx4bCfDTdvYxYZ1cB8nAs6isCeEAYNJBv
         Pps9RapL5WAsgQilSYxiJd44RCAL5mBJUJj1ZdzfixjB18nT5P4gNkJgbPpQHFeshs+V
         NO5rem4XAk+HkN7WL23pgEZhSUHi05b8QGerq/AABRZP1gghbu2aNX/j7bnKT9R4a7l9
         DHtL9WpEpyATF8GYD7CJegB77LpzGII1dBOEKENzHUdXPYQCTXyTT0zGvW6ameop84QM
         k95Frkrarcpf2cWDVrf3gipXQMK3Uu659Kqh3Y3RmlNuwx7GENahd2QHwdrumW9oBuRB
         V25w==
X-Gm-Message-State: AOAM533jwiBKbnZs44sHNk5OCnEI0uKvBHuJx3rcaYhTY1gPOhgGI1Sw
        1prB3BnDouaEafSWAamKSGwzakXRCuvcVtK2USJdg0R/
X-Google-Smtp-Source: ABdhPJxd9a5yL1iNShfHJgrvKpD8OWV5OxxCO0/GOK5tI5MWHvy6qdsDqO2rXgbWtAzc/eW3dOh1BE4oaSrv3nYE2nc=
X-Received: by 2002:a05:6808:f14:: with SMTP id m20mr19943407oiw.13.1618230546220;
 Mon, 12 Apr 2021 05:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <SN6PR01MB3648B4FC16E10CA1B04F756587749@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W7K7ir+CLxMkXGMYbxuvDEEJD5vNW2arbLLiaSKrGtbLg@mail.gmail.com>
 <SN6PR01MB3648AD0120B58D72E5B0C00F87739@SN6PR01MB3648.prod.exchangelabs.com>
 <CAB_54W4j7G53YT8G32GdM4pNET8i0v9_zkNMe=0dwdfbHvEXFg@mail.gmail.com> <SN6PR01MB3648864C8E0A272EAC656AEA87739@SN6PR01MB3648.prod.exchangelabs.com>
In-Reply-To: <SN6PR01MB3648864C8E0A272EAC656AEA87739@SN6PR01MB3648.prod.exchangelabs.com>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Mon, 12 Apr 2021 08:28:55 -0400
Message-ID: <CAB_54W4P4Y8q-A4x9H+zA7bf8KR=Qb7CFoxn24JuasiGSnHzTQ@mail.gmail.com>
Subject: Re: things not working - newbie questions
To:     Mark Butsch <Mark.Butsch@myfuelmaster.com>
Cc:     "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Fri, 9 Apr 2021 at 12:59, Mark Butsch <Mark.Butsch@myfuelmaster.com> wrote:
...
>
> I feel I am missing some crucial detail.
>

I tried to reproduce it, I don't see any mistake and it does not work
for me as well. However I am not an expert in af802154 socket (I never
touched it so far) it's a very historical growing thing. Maybe Stefan
can help here.
However, I tested an IPv6 ping on my side and it worked. Just do ping6
"fe80....%lowpan0", whereas the address is lowpan1 of course. May I
have at the weekend time to look at it and maybe we can finally start
some next generation socket interface or better make this one less
complicated/fixing bugs (also some netns awareness seems to be
missing, as I figured out?).

I also was looking at wireshark, it was showing some data arriving.

- Alex
