Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1177CC43334
	for <linux-wpan@archiver.kernel.org>; Thu, 16 Jun 2022 07:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359466AbiFPH5o (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 16 Jun 2022 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiFPH5n (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 16 Jun 2022 03:57:43 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A2856FA3;
        Thu, 16 Jun 2022 00:57:42 -0700 (PDT)
Received: from [IPV6:2003:e9:d74a:356f:526e:76c5:79f4:ad31] (p200300e9d74a356f526e76c579f4ad31.dip0.t-ipconnect.de [IPv6:2003:e9:d74a:356f:526e:76c5:79f4:ad31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id A151AC03F6;
        Thu, 16 Jun 2022 09:57:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1655366260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9FfORid6zC3bRP+twwLibJMtyUuxBV7ZhpDR/dcXWuQ=;
        b=wCuRApRcC9mZbBnlFMgL0sP25ZFrAHDfn3li5MOLJQi1nthJHDd3OcfkH3nYTCPlFe3Ml/
        GFD000b0blOLSZ4yquFfPePow2HacDvYeqANiDs7QLg/KcZ03OU6+A8mMamhjuRb/Js9/N
        zZdGj/QMFgzOcOsSaO5gZ5lzPwfo2m7aSukG4ZicwMUPALjcPU9gKooik6OSQvymX3fGL1
        zPznS5rrLElpGE5zBn0gHLAr85YriTcUu7KJ7VZ+BqhcBifjEY4nMo9w5XA1Vqp0lfzKbS
        D8FPcxSnd1fsn0qFEbadkwBg1cBwSuR9XpUlJEcOz08iCMr8U2tylJH9dYeaCg==
Message-ID: <e3efe652-eb22-4a3f-a121-be858fe2696b@datenfreihafen.org>
Date:   Thu, 16 Jun 2022 09:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: 6lowpan netlink
Content-Language: en-US
To:     Alexander Aring <aahringo@redhat.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>
References: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <CAK-6q+g1jy-Q911SWTGVV1nw8GAbEAVYSAKqss54+8ehPw9RDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Alex.

On 13.06.22 05:44, Alexander Aring wrote:
> Hi all,
> 
> I want to spread around that I started to work on some overdue
> implementation, a netlink 6lowpan configuration interface, because
> rtnetlink is not enough... it's for configuring very specific 6lowpan
> device settings.

Great, looking forward to it!

regards
Stefan Schmidt
