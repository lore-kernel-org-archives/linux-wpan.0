Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCF0C43334
	for <linux-wpan@archiver.kernel.org>; Thu,  2 Jun 2022 17:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbiFBRmN (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 2 Jun 2022 13:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiFBRmM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 2 Jun 2022 13:42:12 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8E23CF79;
        Thu,  2 Jun 2022 10:42:07 -0700 (PDT)
Received: from [IPV6:2003:e9:d738:31bf:d5a9:1442:9319:c966] (p200300e9d73831bfd5a914429319c966.dip0.t-ipconnect.de [IPv6:2003:e9:d738:31bf:d5a9:1442:9319:c966])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 185C2C05A1;
        Thu,  2 Jun 2022 19:42:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1654191726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dJjAe7GezGQ4ziqIBIGNRq/AcDL0a6kGTbX3b+UDhOA=;
        b=jK6daDkHPkBW9m2cRQ7luAKoMYNFQK6ygkzj8l6Tnel4pvrTESh6li+1DgXP31FYDeAfo4
        Esg0Xi9sCHNn7a4nsSvan0uVBSzCKGJHFRczbQyMelTEgeHNjayfPObVBDxDWMKh0aHKm5
        QDnaEFNadIMywJ5cGzNgk6u0neGKJ/TkdsIilLuT/QMZvXTTxmuphgM7PQzjZxOQIe/bVx
        GWb3oydhF1EBshLPtJ5AidTMEdEtNN8bNJoGAvk/YroVoNQOfBDHzwUcHGhqjk/b/KI+3Q
        xOfJIAmK9840vf/2lxBLCJMtxvXv7ImVAmft7xXVDAQs7ijXPMVuQAzW0H+0EA==
Message-ID: <5d1a3523-160f-8cab-76e8-868fffd0881a@datenfreihafen.org>
Date:   Thu, 2 Jun 2022 19:42:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] MAINTAINERS: Remove Jukka Rissanen as 6lowpan maintainer
Content-Language: en-US
To:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        alex.aring@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-wpan@vger.kernel.org,
        pmenzel@molgen.mpg.de
References: <20220526162806.16618-1-jukka.rissanen@linux.intel.com>
 <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20220527075625.9693-1-jukka.rissanen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org


Hello.

On 27.05.22 09:56, Jukka Rissanen wrote:
> I no longer work on this so better update the file.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6618e9b91b6c..2e03de59d700 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -171,7 +171,6 @@ F:	drivers/scsi/53c700*
>   
>   6LOWPAN GENERIC (BTLE/IEEE 802.15.4)
>   M:	Alexander Aring <alex.aring@gmail.com>
> -M:	Jukka Rissanen <jukka.rissanen@linux.intel.com>
>   L:	linux-bluetooth@vger.kernel.org
>   L:	linux-wpan@vger.kernel.org
>   S:	Maintained


This patch has been applied to the wpan-next tree and will be
part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
