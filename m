Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098E5E784AC
	for <linux-wpan@archiver.kernel.org>; Mon,  2 Oct 2023 13:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjJBN32 (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 Oct 2023 09:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbjJBN31 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Oct 2023 09:29:27 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A2AD
        for <linux-wpan@vger.kernel.org>; Mon,  2 Oct 2023 06:29:24 -0700 (PDT)
Received: from [IPV6:2003:e9:d72e:6943:275b:1cf8:24c1:7dd3] (p200300e9d72e6943275b1cf824c17dd3.dip0.t-ipconnect.de [IPv6:2003:e9:d72e:6943:275b:1cf8:24c1:7dd3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 226A2C0188;
        Mon,  2 Oct 2023 15:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1696253362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWfSjLudmCQk8PdO7pAVXZHLxGTelm+p5jb49N09qpY=;
        b=nDMq0oqSRqqmOpqII4HaFHrVK5y2Ovyvp5gh/+l5ktjmteKmM0wjzl2bZ07drLnfFOGQUF
        9t+M5s09ZoMsKsHmojOiFjj1LMCnuWMzBM0jP02p9DPfIJAr4sXwzZu9eMhquWF5Q1gzDb
        Vzi6kt8POzdlBu3J+DNLWOU5T2SItlFy9rms19Wsncyt3hSumUDcPTiXIWnA9f+/6SvBdi
        qNiB5I0SYIzFDES9UULFSM3gaA9OAvCoBUQJ8ye3Gfsm/YPZc+cP2D2RcLXzEIHVbAUuuY
        xtJHT8DHg9iFLE5CfztZkn/p4owjXxWIsbSnrv6ToRWb+cGET/5/vGtk/TtBvg==
Message-ID: <c55050fa-1b56-f83f-1d0f-b52ee9fe17ed@datenfreihafen.org>
Date:   Mon, 2 Oct 2023 15:29:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/9] src/nl802154.h: switch file to SPDX header for
 license and copyright
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        miquel.raynal@bootlin.com, david.girault@qorvo.com
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
 <20230924122231.716878-6-stefan@datenfreihafen.org>
 <CAK-6q+gsfJqyNUGsyuQkk=b4eTBEEJ_SHEaXLqz7jrr_6bEu8Q@mail.gmail.com>
Content-Language: en-US
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+gsfJqyNUGsyuQkk=b4eTBEEJ_SHEaXLqz7jrr_6bEu8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 02.10.23 01:33, Alexander Aring wrote:
> Hi,
> 
> On Sun, Sep 24, 2023 at 8:24 AM Stefan Schmidt
> <stefan@datenfreihafen.org> wrote:
>>
>> This file has its own commit as we are syncing it between the Linux
>> kernel and this project when new netlink functionality is added.
>>
>> The same change needs to be done on the iLinux kernel side as well to
>> avoid conflicts.
>>
> 
> the iLinux kernel? :) The Linux fork running on an iPhone?
> 
> It's okay... you don't need to fix it.

I had to add the reviewed by tag from Miquel anyway so I fixed the typo 
up before pushing.

regards
Stefan Schmidt
