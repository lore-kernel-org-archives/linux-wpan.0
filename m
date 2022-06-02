Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C504C433EF
	for <linux-wpan@archiver.kernel.org>; Thu,  2 Jun 2022 17:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbiFBRlG (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFBRlF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Jun 2022 13:41:05 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770121C4F04;
        Thu,  2 Jun 2022 10:41:04 -0700 (PDT)
Received: from [IPV6:2003:e9:d738:31bf:d5a9:1442:9319:c966] (p200300e9d73831bfd5a914429319c966.dip0.t-ipconnect.de [IPv6:2003:e9:d738:31bf:d5a9:1442:9319:c966])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id E6612C0092;
        Thu,  2 Jun 2022 19:41:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1654191662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cd1/zrtMFHcKeqGlj0MZxeZZZ/9ysQ0FI/8p6sv4bc=;
        b=fVpSJ0oI3SlkaW9aAcllySk9hssJayNyNPJ+X5lHqCu0pEuvNYYEbpBZFeK9d6IlY/xka9
        NSoQoQUPO4yfjAH/nCxZv/uLopzyuhlRaaUu3tOUqKhQg4/HBWRMHGZnFa8iK44dEEQNWs
        GZIF72O/TPJvw1u6cTd3ZBf2roBqT6Qaeah6WottVnTmrNje8LAY1fLJ6VjfYwZ2jw8B3b
        AnuxBluaFjUvzAn7V63/XryK3IQrYfnQ2zqixaNUffLjEEYHgEtJbHfbMHwhYndZu/au13
        xQBiAml/lXLdhuL0+t1o14533P5t444dki2pImRl7VAaA97raLiRDQ0U7obkSw==
Message-ID: <0d269542-ec85-618b-a389-eb174f0e4dcb@datenfreihafen.org>
Date:   Thu, 2 Jun 2022 19:41:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bluetooth-next 0/3] net: 6lowpan: simplify lookup by nhc
 id
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        jukka.rissanen@linux.intel.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        torvalds@linuxfoundation.org
References: <20220428030534.3220410-1-aahringo@redhat.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20220428030534.3220410-1-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 28.04.22 05:05, Alexander Aring wrote:
> Hi,
> 
> this patch series removes the rb data structure for looking up a nhc by
> nhc id. Instead we using the existing nexthdr lookup array by iterating
> over it and find the right nhc by nhc id. It's simply not worth it to
> use such complex handling for such small amount of nhc. As we only
> support nhc ids which fits into 1 byte and there are not two byte nhc
> ids values specified yet, we let the nhc layer only handle 1 byte values.
> If there is the need for 2 byte nhc values we can add support for it.
> 
> - Alex
> 
> Alexander Aring (3):
>    net: 6lowpan: remove const from scalars
>    net: 6lowpan: use array for find nhc id
>    net: 6lowpan: constify lowpan_nhc structures
These patches have been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
