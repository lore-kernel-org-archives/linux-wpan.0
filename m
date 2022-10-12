Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B38C433FE
	for <linux-wpan@archiver.kernel.org>; Wed, 12 Oct 2022 10:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJLK7j (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 12 Oct 2022 06:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiJLK7i (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Oct 2022 06:59:38 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1207FA2841;
        Wed, 12 Oct 2022 03:59:34 -0700 (PDT)
Received: from [IPV6:2003:e9:d70e:f1c1:fef2:18a8:26e3:47fd] (p200300e9d70ef1c1fef218a826e347fd.dip0.t-ipconnect.de [IPv6:2003:e9:d70e:f1c1:fef2:18a8:26e3:47fd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 62C1DC00A3;
        Wed, 12 Oct 2022 12:59:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1665572371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lg3mwezL7kS9p+M2i6b50z2k3RSNa2i6K+CEUCIw2Qg=;
        b=aD4B+inHnGpb1lZ8T0NPJSe6xRwJCqrKDzoKFIc2/ALVSJ08umjo+Pu67ktnX5bKlX6/CL
        mbwz12ZjMfQk+MuwDNk7aEHIZDcbV3bOaGYBaUmLP8pkVfC6Zp2OI9xuQnvK9HDHW1OlvT
        f9ZhOrBLVoh0cD/RZDLc8pmm+b3l1GNDs4QpAQWZpiyInboOQACg83qE/c8d+KkHLXHLwq
        70Lheun8uFazMH9aFYP0BcMEF+SMigskIAxs01zN4qVF5SUF7CDmg+72SznpO3N9nE6D5T
        803F126yt9Hu8KCFLHIBn1LBwo2L7YXj4460X12g2yz1+bTqBTZagHuc9xonmw==
Message-ID: <a656d2b9-7c4f-a340-9dd6-8da57004fb9e@datenfreihafen.org>
Date:   Wed, 12 Oct 2022 12:59:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH wpan/next v4 0/8] net: ieee802154: Improve filtering
 support
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20221007085310.503366-1-miquel.raynal@bootlin.com>
 <CAK-6q+i6LPM2YjCCaWU-LL6vFUCY=SweiWDJrA12M1cKtNYGUQ@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+i6LPM2YjCCaWU-LL6vFUCY=SweiWDJrA12M1cKtNYGUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel.

On 11.10.22 03:01, Alexander Aring wrote:
> Hi,
> 
> On Fri, Oct 7, 2022 at 4:53 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>>
>> Hello,
>>
>> A fourth version of this series, where we try to improve filtering
>> support to ease scan integration. Will then come a short series about
>> the coordinator interfaces and then the proper scan series.
>>
> 
> I think this patch series goes into the right direction. So I would
> give it a go:
> 
> Acked-by: Alexander Aring <aahringo@redhat.com>


Besides patch 8 these patches have been applied to the wpan-next tree 
and will be part of the next pull request to net-next. Thanks!

regards
Stefan Schmidt
