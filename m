Return-Path: <SRS0=wjBD=AA=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAA0C433E0
	for <linux-wpan@archiver.kernel.org>; Fri, 19 Jun 2020 07:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E96B02078D
	for <linux-wpan@archiver.kernel.org>; Fri, 19 Jun 2020 07:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbgFSHOa (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:14:30 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:35800 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729859AbgFSHOa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2020 03:14:30 -0400
Received: from PC192.168.2.51 (p200300e9d71c614f3cb31ed73bdb933f.dip0.t-ipconnect.de [IPv6:2003:e9:d71c:614f:3cb3:1ed7:3bdb:933f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 38C84C0547;
        Fri, 19 Jun 2020 09:14:24 +0200 (CEST)
Subject: Re: [PATCH 1/2] docs: net: ieee802154: change link to new project URL
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-wpan@vger.kernel.org,
        alex.aring@gmail.com
References: <20200616065814.816248-1-stefan@datenfreihafen.org>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <c8631876-8aea-c56d-105e-6866c74964ce@datenfreihafen.org>
Date:   Fri, 19 Jun 2020 09:14:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200616065814.816248-1-stefan@datenfreihafen.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Dave.

On 16.06.20 08:58, Stefan Schmidt wrote:
> We finally came around to setup a new project website.
> Update the reference here.
> 
> Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
> ---
>   Documentation/networking/ieee802154.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/networking/ieee802154.rst b/Documentation/networking/ieee802154.rst
> index 36ca823a1122..6f4bf8447a21 100644
> --- a/Documentation/networking/ieee802154.rst
> +++ b/Documentation/networking/ieee802154.rst
> @@ -30,8 +30,8 @@ Socket API
>   
>   The address family, socket addresses etc. are defined in the
>   include/net/af_ieee802154.h header or in the special header
> -in the userspace package (see either http://wpan.cakelab.org/ or the
> -git tree at https://github.com/linux-wpan/wpan-tools).
> +in the userspace package (see either https://linux-wpan.org/wpan-tools.html
> +or the git tree at https://github.com/linux-wpan/wpan-tools).
>   
>   6LoWPAN Linux implementation
>   ============================
> 

I see you marked both patches here as awaiting upstream in patchwork. I 
am not really sure what to do best now. Am I supposed to pick them up 
myself and send them in my usual ieee802154 pull request?

Before you had been picking up docs and MAINTAINERS patches directly. I 
am fine with either way. Just want to check what you expect.

regards
Stefan Schmidt
