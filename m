Return-Path: <SRS0=c9gK=CG=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596BBC433E6
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Aug 2020 14:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D144820639
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Aug 2020 14:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ni.fr.eu.org header.i=@ni.fr.eu.org header.b="k2w2bFj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgH1OeA (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:34:00 -0400
Received: from riva4.ni.fr.eu.org ([91.121.114.4]:52406 "EHLO
        riva4.ni.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgH1Od6 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Aug 2020 10:33:58 -0400
X-Greylist: delayed 457 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Aug 2020 10:33:58 EDT
Received: by riva4.ni.fr.eu.org (Postfix, from userid 1000)
        id 8095BE2348; Fri, 28 Aug 2020 16:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.fr.eu.org;
        s=riva4-20190323; t=1598624776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfnknNZ3qrPAd1FBqPXD1KjwsxjT5WBnTqMoJijaBEY=;
        b=k2w2bFj81WB23ULsvwn0TmwcG2027JH5mETuOe4jtIfargXM8qd6bna9xT2b86e7Mz30BI
        9zyVbkjyrxA0dksnw1RDB1gvMokh/EF7zRyReQwQMwfG9S6Ps+h0k7sQcawSZuh0waHdUi
        k+vd9tkR7pFu2X5xgHwF0Xwm6WGJs04=
Date:   Fri, 28 Aug 2020 16:26:16 +0200
From:   Nicolas Schodet <nico@ni.fr.eu.org>
To:     Christopher Friedt <chrisfriedt@gmail.com>
Cc:     linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Michael Magyar <michael.magyarm@gmail.com>
Subject: Re: MAC Layer Beacon / Scan Code
Message-ID: <20200828142616.GI5022@ni.fr.eu.org>
References: <CAF4BF-TVe09FUdWZLw9dQf1=d0q-2w=Ey7LXx61rHBOtvczmBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF4BF-TVe09FUdWZLw9dQf1=d0q-2w=Ey7LXx61rHBOtvczmBw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

* Christopher Friedt <chrisfriedt@gmail.com> [2020-08-27 12:59]:
> Hi everyone,
> I thought it was lost after I moved on to a different employer, but my
> former colleague Michael Magyar managed to dig up some work that we
> had done back in 2015.
> I unfortunately do not know if my branch still exists, but it looks
> like his copy of it is still intact.
> https://github.com/magyarm/bluetooth-next/tree/feature/nl802154-get-active-scan-req
> https://github.com/magyarm/bluetooth-next/tree/feature/nl802154-beacon
> We had some additional changes for wpan-tools. Hopefully we can find
> those as well.
> These changes should allow us to create something along the lines of
> Network Manager for IEEE 802.15.4 or even to do some automated channel
> joining, etc.
> Let's keep this thread open and try to rebase patches & get some
> patches posted for review soon.
> Cheers,
> C

Hello,

We are working too on the same kind of features, I am “ni” on
#linux-wpan. For the moment, we have a quite advanced branch for
scanning (active and passive) which tries to mirror what is done in the
802.11 stack, written by David, and another branch for joining a PAN
by Thierry.

I would be interrested to see a rebase to better understand what you
have done.

I asked David to prepare a branch to share so we can see how to move
forward.

Nicolas.
