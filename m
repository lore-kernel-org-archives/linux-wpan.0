Return-Path: <SRS0=u07r=X2=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCDFC32792
	for <linux-wpan@archiver.kernel.org>; Tue,  1 Oct 2019 00:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 590ED20815
	for <linux-wpan@archiver.kernel.org>; Tue,  1 Oct 2019 00:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbfJAAPm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 30 Sep 2019 20:15:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:40476 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbfJAAPm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 30 Sep 2019 20:15:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0C9A8154F636A;
        Mon, 30 Sep 2019 17:15:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:15:41 -0700 (PDT)
Message-Id: <20190930.171541.2128948484618455420.davem@davemloft.net>
To:     stefan@datenfreihafen.org
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        netdev@vger.kernel.org
Subject: Re: pull-request: ieee802154 for net 2019-09-28
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190928075737.28132-1-stefan@datenfreihafen.org>
References: <20190928075737.28132-1-stefan@datenfreihafen.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 30 Sep 2019 17:15:42 -0700 (PDT)
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

From: Stefan Schmidt <stefan@datenfreihafen.org>
Date: Sat, 28 Sep 2019 09:57:37 +0200

> An update from ieee802154 for your *net* tree.
> 
> Three driver fixes. Navid Emamdoost fixed a memory leak on an error
> path in the ca8210 driver, Johan Hovold fixed a use-after-free found
> by syzbot in the atusb driver and Christophe JAILLET makes sure
> __skb_put_data is used instead of memcpy in the mcr20a driver
> 
> I switched from branches to tags here to be pulled from. So far not
> annotated and not signed. Once I fixed my scripts it should contain
> this messages as annotations. If you want it signed as well just tell
> me. If there are any problems let me know.
 ...
>   git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git tags/ieee802154-for-davem-2019-09-28

Pulled, thanks.
