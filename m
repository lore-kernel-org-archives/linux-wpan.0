Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4ECC6FD1C
	for <linux-wpan@archiver.kernel.org>; Thu, 23 Mar 2023 20:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjCWU5O (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 23 Mar 2023 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjCWU5A (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 23 Mar 2023 16:57:00 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42F21A37
        for <linux-wpan@vger.kernel.org>; Thu, 23 Mar 2023 13:56:29 -0700 (PDT)
Received: from [IPV6:2003:e9:d711:5f8f:7b5e:613a:60e4:7837] (p200300e9d7115f8f7b5e613a60e47837.dip0.t-ipconnect.de [IPv6:2003:e9:d711:5f8f:7b5e:613a:60e4:7837])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 7AF36C006B;
        Thu, 23 Mar 2023 21:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1679604984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/J+bTMpO37ibHgc0ziEL3htj1gphR5jVu1dbZEwVRfM=;
        b=tstKzV9r9fyKcYRetVCXUqbNooDDYZprK/1p0ZetRfpsQT1AcnQg+SpFvyItnOKvmFObDk
        mdYb58WOP4vfi8W0Z/Q3S7Ve32Iqn2VmYCQsCluzntw2uxN2XArkAb73rPsCGBq5uCJ+k3
        haUqzEETddsySXxKeM/FFhAeXhUseTi0sk7rWWaHUX5wgNIlAY4v4FtA/ClE/21tACUIIx
        p5kHVZ0cUaR2iPNnfJYdUZThukYuJHSqdhYrYfubj8Z8qQdyErkY3ApwXPjYqcVrxSjvpl
        1z1zZxhSjmtR3B6/4Dun8E6ziazYbSDLPW9Q9jQ8rST8LbqPUTlFeO1suLG/fQ==
Message-ID: <fa58be03-6fd5-4786-7b67-8af6093ca1c4@datenfreihafen.org>
Date:   Thu, 23 Mar 2023 21:56:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH wpan-next v2 0/4] ieee802154: Active scan support
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Guilhem Imberton <guilhem.imberton@qorvo.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230310145346.1397068-1-miquel.raynal@bootlin.com>
 <CAK-6q+iw6V5qDCux0E4xE3wMuCc1u8tc26kzwQFyHbMcyFr4iQ@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+iw6V5qDCux0E4xE3wMuCc1u8tc26kzwQFyHbMcyFr4iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 23.03.23 13:58, Alexander Aring wrote:
> Hi,
> 
> On Fri, Mar 10, 2023 at 10:12 AM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>>
>> Hello,
>> Following the initial support for passive scan and beaconing, here is an
>> addition to support active scans.
>> Thanks,
>> Miquèl
> 
> Acked-by: Alexander Aring <aahringo@redhat.com>

This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
