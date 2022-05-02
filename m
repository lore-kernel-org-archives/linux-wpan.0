Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B4DC433F5
	for <linux-wpan@archiver.kernel.org>; Mon,  2 May 2022 19:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiEBTkw (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 2 May 2022 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiEBTkv (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 May 2022 15:40:51 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175B065CF
        for <linux-wpan@vger.kernel.org>; Mon,  2 May 2022 12:37:21 -0700 (PDT)
Received: from [IPV6:2003:e9:d724:5eaf:7962:46e1:bce5:9013] (p200300e9d7245eaf796246e1bce59013.dip0.t-ipconnect.de [IPv6:2003:e9:d724:5eaf:7962:46e1:bce5:9013])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 7A01AC0F56;
        Mon,  2 May 2022 21:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1651520239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8hGpWv1RDWq7kf4AFO9qh9ojGqRMzUceRRnpQPDO0dE=;
        b=Rks4ubu/diMPgrqGQP2T2Z0cz6Aom8UvuBG+kMA5IRi/wtwvEy4CnxzAFx7lcEn+58iLMn
        vtb/xNxbyaZ8iCDykaBuZdR+Ra14/ELhWwC+ZKDnkChhb5KMIeIhyxDjNbDgWKJHKiQ36a
        KEspgCNYdRfM3eXajCvu6KA3QQ2WaiZx0kC/HLXjW3Cpd/ia7B5uRu2xii6+Sj97tO1vOk
        vnf72X7gN8lQlu7l6J0GSnChrDD9GIYWzg/1xnRvxuCSIw9NPh3o3z7qRAuuf2MvTtK+V8
        FR0ijG6pt8tB1s9+XzKY/zXk0LspprXTa1Hl69GnGbzz/LVZ784RQA4rZDhCQQ==
Message-ID: <6009d104-7f73-0acb-0e34-f4a90534e226@datenfreihafen.org>
Date:   Mon, 2 May 2022 21:37:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH bluetooth-next 3/3] net: 6lowpan: constify lowpan_nhc
 structures
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        jukka.rissanen@linux.intel.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        torvalds@linuxfoundation.org
References: <20220428030534.3220410-1-aahringo@redhat.com>
 <20220428030534.3220410-4-aahringo@redhat.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20220428030534.3220410-4-aahringo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


Hello.

On 28.04.22 05:05, Alexander Aring wrote:
> This patch constify the lowpan_nhc declarations. Since we drop the rb
> node datastructure there is no need for runtime manipulation of this
> structure.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>   net/6lowpan/nhc.c | 16 ++++++++--------
>   net/6lowpan/nhc.h |  6 +++---
>   2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/net/6lowpan/nhc.c b/net/6lowpan/nhc.c
> index 019f121b2449..7b374595328d 100644
> --- a/net/6lowpan/nhc.c
> +++ b/net/6lowpan/nhc.c
> @@ -12,12 +12,12 @@
>   
>   #include "nhc.h"
>   
> -static struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
> +static const struct lowpan_nhc *lowpan_nexthdr_nhcs[NEXTHDR_MAX + 1];
>   static DEFINE_SPINLOCK(lowpan_nhc_lock);
>   
> -static struct lowpan_nhc *lowpan_nhc_by_nhcid(struct sk_buff *skb)
> +static const struct lowpan_nhc *lowpan_nhc_by_nhcid(struct sk_buff *skb)
>   {
> -	struct lowpan_nhc *nhc;
> +	const struct lowpan_nhc *nhc;
>   	int i;
>   	u8 id;
>   
> @@ -41,7 +41,7 @@ static struct lowpan_nhc *lowpan_nhc_by_nhcid(struct sk_buff *skb)
>   int lowpan_nhc_check_compression(struct sk_buff *skb,
>   				 const struct ipv6hdr *hdr, u8 **hc_ptr)
>   {
> -	struct lowpan_nhc *nhc;
> +	const struct lowpan_nhc *nhc;
>   	int ret = 0;
>   
>   	spin_lock_bh(&lowpan_nhc_lock);
> @@ -59,7 +59,7 @@ int lowpan_nhc_do_compression(struct sk_buff *skb, const struct ipv6hdr *hdr,
>   			      u8 **hc_ptr)
>   {
>   	int ret;
> -	struct lowpan_nhc *nhc;
> +	const struct lowpan_nhc *nhc;
>   
>   	spin_lock_bh(&lowpan_nhc_lock);
>   
> @@ -102,7 +102,7 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
>   				const struct net_device *dev,
>   				struct ipv6hdr *hdr)
>   {
> -	struct lowpan_nhc *nhc;
> +	const struct lowpan_nhc *nhc;
>   	int ret;
>   
>   	spin_lock_bh(&lowpan_nhc_lock);
> @@ -138,7 +138,7 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
>   	return 0;
>   }
>   
> -int lowpan_nhc_add(struct lowpan_nhc *nhc)
> +int lowpan_nhc_add(const struct lowpan_nhc *nhc)
>   {
>   	int ret = 0;
>   
> @@ -156,7 +156,7 @@ int lowpan_nhc_add(struct lowpan_nhc *nhc)
>   }
>   EXPORT_SYMBOL(lowpan_nhc_add);
>   
> -void lowpan_nhc_del(struct lowpan_nhc *nhc)
> +void lowpan_nhc_del(const struct lowpan_nhc *nhc)
>   {
>   	spin_lock_bh(&lowpan_nhc_lock);
>   
> diff --git a/net/6lowpan/nhc.h b/net/6lowpan/nhc.h
> index 9df602a632bd..ab7b4977c32b 100644
> --- a/net/6lowpan/nhc.h
> +++ b/net/6lowpan/nhc.h
> @@ -24,7 +24,7 @@
>   #define LOWPAN_NHC(__nhc, _name, _nexthdr,	\
>   		   _hdrlen, _id, _idmask,	\
>   		   _uncompress, _compress)	\
> -static struct lowpan_nhc __nhc = {		\
> +static const struct lowpan_nhc __nhc = {	\
>   	.name		= _name,		\
>   	.nexthdr	= _nexthdr,		\
>   	.nexthdrlen	= _hdrlen,		\
> @@ -116,14 +116,14 @@ int lowpan_nhc_do_uncompression(struct sk_buff *skb,
>    *
>    * @nhc: nhc which should be add.
>    */
> -int lowpan_nhc_add(struct lowpan_nhc *nhc);
> +int lowpan_nhc_add(const struct lowpan_nhc *nhc);
>   
>   /**
>    * lowpan_nhc_del - delete a next header compression from framework
>    *
>    * @nhc: nhc which should be delete.
>    */
> -void lowpan_nhc_del(struct lowpan_nhc *nhc);
> +void lowpan_nhc_del(const struct lowpan_nhc *nhc);
>   
>   /**
>    * lowpan_nhc_init - adding all default nhcs

Reviewed-by: Stefan Schmidt <stefan@datenfreihafen.org>

regards
Stefan Schmidt
