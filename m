Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6211C433ED
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Apr 2021 20:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76034613D2
	for <linux-wpan@archiver.kernel.org>; Tue,  6 Apr 2021 20:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhDFU3r (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 6 Apr 2021 16:29:47 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:54778 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhDFU3r (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 6 Apr 2021 16:29:47 -0400
Received: from [IPv6:2003:e9:d71d:a9d1:9fa1:9dd5:9888:d937] (p200300e9d71da9d19fa19dd59888d937.dip0.t-ipconnect.de [IPv6:2003:e9:d71d:a9d1:9fa1:9dd5:9888:d937])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 837E2C00BF;
        Tue,  6 Apr 2021 22:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1617740977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v+Aa34mrYRYXTRnPmxDapeYdZ+YqBsHbucIpuyF0UhE=;
        b=Ckpb/CRzhe0/dfo2zJTRIuzHFXeC64bYXWdZ+8H9N1V2h+PO7K5CS5Gq7yizDa8aVH2BM0
        nCzm+PZ61tIRihK9vXW/9THdpwIcYVyH361COhQNbzw83eTsECe648EorYGEWAJZDFvdYQ
        uecoSALRtorgvyUtdIozbLsNqWHM/Wjz62C9qYyrCbXXsXji4joD83CAxs+c32VMtaGElZ
        WoriYo9Disvtv1x951/W9diAtSq710/tqbkPGGfH+kw2tkdJ1Va9F/K0czRmXETUbxzIhM
        oyj7AhQDkoaQa93edIG3Hnbe5PEBnP5qtvLkN02ViS1ujeqPsddrKzDVHXcV2w==
Subject: Re: [PATCH RESEND wpan 00/15] net: ieee802154: forbid sec params for
 monitors
To:     Alexander Aring <aahringo@redhat.com>
Cc:     linux-wpan@vger.kernel.org, netdev@vger.kernel.org
References: <20210405003054.256017-1-aahringo@redhat.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <ff309881-1312-1c81-973f-f7ec125c0f29@datenfreihafen.org>
Date:   Tue, 6 Apr 2021 22:29:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210405003054.256017-1-aahringo@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello.

On 05.04.21 02:30, Alexander Aring wrote:
> Hi,
> 
> this patch series contains fixes to forbid various security parameters
> settings for monitor types. Monitor types doesn't use the llsec security
> currently and we don't support it. With this patch series the user will
> be notified with a EOPNOTSUPP error that for monitor interfaces security
> is not supported yet. However there might be a possibility in future
> that the kernel will decrypt frames with llsec information for sniffing
> frames and deliver plaintext to userspace, but this isn't supported yet.
> 
> - Alex
> 
> Alexander Aring (15):
>    net: ieee802154: nl-mac: fix check on panid
>    net: ieee802154: forbid monitor for set llsec params
>    net: ieee802154: stop dump llsec keys for monitors
>    net: ieee802154: forbid monitor for add llsec key
>    net: ieee802154: forbid monitor for del llsec key
>    net: ieee802154: stop dump llsec devs for monitors
>    net: ieee802154: forbid monitor for add llsec dev
>    net: ieee802154: forbid monitor for del llsec dev
>    net: ieee802154: stop dump llsec devkeys for monitors
>    net: ieee802154: forbid monitor for add llsec devkey
>    net: ieee802154: forbid monitor for del llsec devkey
>    net: ieee802154: stop dump llsec seclevels for monitors
>    net: ieee802154: forbid monitor for add llsec seclevel
>    net: ieee802154: forbid monitor for del llsec seclevel
>    net: ieee802154: stop dump llsec params for monitors
> 
>   net/ieee802154/nl-mac.c   |  7 +++---
>   net/ieee802154/nl802154.c | 52 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+), 3 deletions(-)
> 

This series has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
