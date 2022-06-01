Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42A5C43334
	for <linux-wpan@archiver.kernel.org>; Wed,  1 Jun 2022 20:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiFAUpN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 1 Jun 2022 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiFAUnw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 1 Jun 2022 16:43:52 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27201E4514;
        Wed,  1 Jun 2022 13:28:41 -0700 (PDT)
Received: from [IPV6:2003:e9:d72e:f86c:6f28:ee17:a8de:98f4] (p200300e9d72ef86c6f28ee17a8de98f4.dip0.t-ipconnect.de [IPv6:2003:e9:d72e:f86c:6f28:ee17:a8de:98f4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 86433C0092;
        Wed,  1 Jun 2022 22:28:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1654115317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bYesnbLNm6NR5A6+Q6J3A6lN4oBm0gztPKEpqNSh1XU=;
        b=g70UjYn7M399VlGsAV4Q0LXZ7zeaV3XWO8XlSR3zNtj9cnmo6lSx+BNC5JLqER3xuYOGHm
        5ENiHbzpi/y3W9afZ6H/nX0DQHJ8jvsxCxBc7Q6KdSQlAbRy3QeziIAWL62qfFkW9OtCva
        ncgU+9PicDe2fjzUWvoiCaKQbcIUE2zwdjX6Rj9PBNhdpgx7T6BPrh4EwceoTU4EWRvFiY
        /pKd92i9mCspmK9zWbXE+Sjq0SK8kuyek+q8RmjcRqXLy5fIqR/iSwT2tp2wbCLGj7Xehz
        DR4ehGW+ht/rqobOMAx/7sx3HmG/tILMZXOJKGC4W3md5BU4h+ds+GUgf5xQng==
Message-ID: <06164dbe-3c11-c627-0929-a399414c01bf@datenfreihafen.org>
Date:   Wed, 1 Jun 2022 22:28:35 +0200
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

Marcel, Luiz, are you still picking up generic 6lowpan patches or only 
the ones for bluetooth?

These three have been around for over a month and acked by me and Jukka, 
but I can't find them anywhere in bluetooth-next or Linus tree.

If 6lowpan is of less concern for you I can route them through my 
ieee80254 tree as well.

regards
Stefan Schmidt
