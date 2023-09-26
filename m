Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2611E7D24C
	for <linux-wpan@archiver.kernel.org>; Tue, 26 Sep 2023 07:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjIZH6b (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Tue, 26 Sep 2023 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjIZH6b (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 26 Sep 2023 03:58:31 -0400
X-Greylist: delayed 156933 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 00:58:24 PDT
Received: from proxima.lasnet.de (proxima.lasnet.de [IPv6:2a01:4f8:121:31eb:3::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B44B8
        for <linux-wpan@vger.kernel.org>; Tue, 26 Sep 2023 00:58:24 -0700 (PDT)
Received: from [IPV6:2003:e9:d70a:c570:868c:bfba:e775:55b0] (p200300e9d70ac570868cbfbae77555b0.dip0.t-ipconnect.de [IPv6:2003:e9:d70a:c570:868c:bfba:e775:55b0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id E3CB1C07E6;
        Tue, 26 Sep 2023 09:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1695715101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kJaw03We0B5OOZ1a4JN2sgD/jXmp/H/Z7NMkZ5xrvSw=;
        b=l9OUt+6jFJYBy6jb9xT7AQBiTk919GuVZrEvFChzhh9VtfbEL9rub8Bb/x4naAZfq8qZmJ
        3J60++U0KMo9WFlPPUO1JHOW8v5mY+TVEyKB2zk+vj9MULY7bz9v+OfMzpwjEcpuPdOB0T
        jdlV4fEaSQP3AWpRqWoCWKc82q3gnAPIrDvttYX/8RIq7MvaUidK0qHST9e2j55LQDb4IJ
        BfB5VClYaqoubsYabiqH11uVLBYz4vJYtE7DmKeuQWd4i2I/QAbpiTIZNsah3BP5OCby2m
        Gk42xMD6W/RKjQwoCeLYpaFXN48xazFYYkdE0vAm8+5C6Pfjve4xDow+41LZkw==
Message-ID: <f390bb8d-c412-97c4-d574-4bde89bae5a2@datenfreihafen.org>
Date:   Tue, 26 Sep 2023 09:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/9] wpan-tools: switch to SPDX header for license and
 copyright
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        david.girault@qorvo.com
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
 <20230925092202.0ab39c04@xps-13>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20230925092202.0ab39c04@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel, Alex.

On 25.09.23 09:22, Miquel Raynal wrote:
> Hi Stefan,
> 
> stefan@datenfreihafen.org wrote on Sun, 24 Sep 2023 14:22:22 +0200:
> 
>> Hello.
>>
>> I took some time to convert wpan-tools over to using the SPDX header format to
>> express copyright and license information. In this process we make the actual
>> license (ISC) more clear and allow downstream users of wpan-tools to have a
>> machine readable format for license compliance.
>>
>> We are also using the reuse tool in our CI to check for this now and generate a
>> SBOM file as an example.
> 
> Nice addition!
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks Miquel.

Alex, any remarks from your side or are you happy for me to land this in 
wpan-tools?

regards
Stefan Schmidt
