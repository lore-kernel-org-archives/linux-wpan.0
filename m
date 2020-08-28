Return-Path: <SRS0=c9gK=CG=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F4AC433E7
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Aug 2020 15:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7148E2075B
	for <linux-wpan@archiver.kernel.org>; Fri, 28 Aug 2020 15:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ni.fr.eu.org header.i=@ni.fr.eu.org header.b="ebn4Tb4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgH1PFI (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:05:08 -0400
Received: from riva4.ni.fr.eu.org ([91.121.114.4]:54694 "EHLO
        riva4.ni.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH1PFI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 28 Aug 2020 11:05:08 -0400
Received: by riva4.ni.fr.eu.org (Postfix, from userid 1000)
        id 796E1E2348; Fri, 28 Aug 2020 17:05:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.fr.eu.org;
        s=riva4-20190323; t=1598627105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o98RozwxFqbnDHZpXWanLiAG1LiXEgdiRCrb4zUB4YQ=;
        b=ebn4Tb4bQ+zOPO1pDPB9ytgkeHtQQz9G8Ht//zmGBgSIX56OMPwGlPFWfJDI0WBHWmfIeC
        NG8j5MgwHLwOk7v+yQ/BAgrlR9NHV2kwsfjPdL9y4Fnk+2YfS/v/Gf2udtgcsfneuIRotX
        gfOc3uKa0zxykDjg99NpSq9QDO3UeLQ=
Date:   Fri, 28 Aug 2020 17:05:05 +0200
From:   Nicolas Schodet <nico@ni.fr.eu.org>
To:     Michael Magyar <michael.magyarm@gmail.com>
Cc:     Christopher Friedt <chrisfriedt@gmail.com>,
        linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: MAC Layer Beacon / Scan Code
Message-ID: <20200828150505.GJ5022@ni.fr.eu.org>
References: <CAF4BF-TVe09FUdWZLw9dQf1=d0q-2w=Ey7LXx61rHBOtvczmBw@mail.gmail.com>
 <20200828142616.GI5022@ni.fr.eu.org>
 <CAF4BF-SikcubXWuQXEm_cieN08d+8_ZKjvNhtGwOmwMC7OSZDw@mail.gmail.com>
 <CANrQGhud-8RL_im99VpuR6ctVTvs32AXSAcMSz+Wyu2ay3Qp1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANrQGhud-8RL_im99VpuR6ctVTvs32AXSAcMSz+Wyu2ay3Qp1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

* Michael Magyar <michael.magyarm@gmail.com> [2020-08-28 11:01]:
> Hello,
> I have found the related wpan-tools branches:
> https://github.com/magyarm/wpan-tools/tree/feature/add-active-scan-request
> https://github.com/magyarm/wpan-tools/tree/feature/add-beacon-notification-command
> https://github.com/magyarm/wpan-tools/tree/feature/association-req
> I'll take a look and refresh my memory on where the code bases were left. I
> think a couple of weeks to clean up the Kernel and wpan-tools branches is
> doable. From there, I hope it'll be useful. If not, I'd be happy to try to
> help where I can.

Thanks! We will also need a week or two to rebase, cleanup and cope with
the other parallel urgent tasks :)

Nicolas.
