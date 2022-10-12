Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A38C4332F
	for <linux-wpan@archiver.kernel.org>; Wed, 12 Oct 2022 17:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJLRyx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 12 Oct 2022 13:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJLRyw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 12 Oct 2022 13:54:52 -0400
Received: from proxima.lasnet.de (proxima.lasnet.de [78.47.171.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDD51FCF9
        for <linux-wpan@vger.kernel.org>; Wed, 12 Oct 2022 10:54:50 -0700 (PDT)
Received: from [IPV6:2003:e9:d728:5820:2c00:8a27:9bcf:7d44] (p200300e9d72858202c008a279bcf7d44.dip0.t-ipconnect.de [IPv6:2003:e9:d728:5820:2c00:8a27:9bcf:7d44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 570F4C01B4;
        Wed, 12 Oct 2022 19:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=datenfreihafen.org;
        s=2021; t=1665597289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UbGVuoxwU+6nX5gL/Hab9aFe/FpsujfoCstiseoRqyg=;
        b=p2XZ2aN/Z+EFpxicmFf3c7wY7C0xn1Eg8GeOZ6y4Pt8aH84QntYgTODMdlIWZElmjBGt5n
        2k7yq9OZo+B/uzQSm09WO9LOR0L3KraiR6y0F9iCZPAhUVL6KuaM9/xUvrNtEM5yjd/lN7
        ceqBNmmH3U6TNpCG/th988C50rFBUP4cswXag4jg7gjAu9LoruawkE7kZGSaTExhkjYFRw
        vvtkr4knJCZpLsdoPfeNDJtqgVO1ICllHnbEo6DLaxY5XFqbparpBQjbkbV0EsTYSmOBi5
        Bkkd1NccEhslEUwneqxI2r+bNsRXUaMQo1ocv3q/ewKqqrWWlNrSKOPjBIRnrg==
Message-ID: <44a98eb6-e8bb-3065-4c6d-9ffb801182ae@datenfreihafen.org>
Date:   Wed, 12 Oct 2022 19:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH atusb/fw v2 2/3] atusb: fw: Update toolchain instructions
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>, werner@almesberger.net
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wpan@vger.kernel.org
References: <20220906082104.1338694-1-miquel.raynal@bootlin.com>
 <20220906082104.1338694-2-miquel.raynal@bootlin.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
In-Reply-To: <20220906082104.1338694-2-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hello Miquel.

On 06.09.22 10:21, Miquel Raynal wrote:
> Those instructions do not work anymore for several reaons:
> - Two out of the three files to download return a 404 error:
>        * The binutils version does not exist, it was 2.21.1 or 2.21.1a
>          instead of just 2.21.
>        * The avr-libc is no longer hosted on the pointed website, I've
>          found an alternate.
> - The binutils version mentioned is not able to compile the firmware on
>    a recent distribution, the Internet advised to update its version and
>    it worked.
> - Most of these compilations will throw warnings if you use a recent
>    gcc. Sometimes -Werror is set and it fails the build. To avoid that,
>    just use --disable-werror in the ./configure options.
> - I had issues building the gcc doc but those issues are trivial to
>    fix inline.
> 
> Update the instructions for building the toolchain and while at it,
> start the file by mentioning that this is maybe not useful anymore, and
> provide the packets to install.

I can see that it was a frustrating process to get this working. :/
Sorry to hear. The truth is only a handful of people did ever build the 
firmware themself, I think. Even I have not done it in a while. (ugh, 5 
years ago most likely judging from the git log).

regards
Stefan Schmidt
