Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31205C433F5
	for <linux-wpan@archiver.kernel.org>; Mon,  2 May 2022 19:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbiEBTkT (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 May 2022 15:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiEBTkR (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 May 2022 15:40:17 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069865CF
        for <linux-wpan@vger.kernel.org>; Mon,  2 May 2022 12:36:46 -0700 (PDT)
Received: from [IPV6:2003:e9:d724:5eaf:7962:46e1:bce5:9013] (p200300e9d7245eaf796246e1bce59013.dip0.t-ipconnect.de [IPv6:2003:e9:d724:5eaf:7962:46e1:bce5:9013])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 9C7AFC06B0;
        Mon,  2 May 2022 21:36:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1651520204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2yJYkAF0okfKvfYQJqFvELAkP/X5eo3gMBzteuSFmQ=;
        b=Ya4pDBohOsPEzl3XtSVrPOS69GfwfQKUQBbHLSc4uzCr3/EUebww5O10/flvilR+nwJ9c6
        0uChQDY8QAFVNoirM8/0rfJA3Aec9zrVT+6Ml+a0SmYP5ZiH6DI6t8K3Y0TS5tpUQq+wux
        el+nBLjZmAI5FLeHT3odS/921gDDJ9viiR6IRo58t5kmi3MFwDbwSded6hBWVyEiLc1uyL
        ENEp0FgPTVJhdfmZzihBz8HmmXRQT4o7BTolsYwewVap+x8DvGn6jLxZiIr9dI8ZW0DVGL
        cmYjQp12e87cw5DtrtfJZebjOM5Z4OcWyaU1lqR8o17iX6iuNgyqPU/TVjIIDA==
Message-ID: <1c903129-37f0-9f0a-662c-b6cb8634cc90@datenfreihafen.org>
Date:   Mon, 2 May 2022 21:36:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bluetooth-next 1/3] net: 6lowpan: remove const from
 scalars
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        jukka.rissanen@linux.intel.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        torvalds@linuxfoundation.org
References: <20220428030534.3220410-1-aahringo@redhat.com>
 <20220428030534.3220410-2-aahringo@redhat.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20220428030534.3220410-2-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


Hello.

On 28.04.22 05:05, Alexander Aring wrote:
> The keyword const makes no sense for scalar types inside the lowpan_nhc
> structure. Most compilers will ignore it so we remove the keyword from
> the scalar types.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>   net/6lowpan/nhc.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
> index 67951c40734b..2ac7da388c4d 100644
> --- a/net/6lowpan/nhc.h
> +++ b/net/6lowpan/nhc.h
> @@ -67,11 +67,11 @@ module_exit(__nhc##_exit);
>   struct lowpan_nhc {
>   	struct rb_node	node;
>   	const char	*name;
> -	const u8	nexthdr;
> -	const size_t	nexthdrlen;
> +	u8		nexthdr;
> +	size_t		nexthdrlen;
>   	u8		*id;
>   	u8		*idmask;
> -	const size_t	idlen;
> +	size_t		idlen;
>   
>   	void		(*idsetup)(struct lowpan_nhc *nhc);
>   	int		(*uncompress)(struct sk_buff *skb, size_t needed);

Reviewed-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
